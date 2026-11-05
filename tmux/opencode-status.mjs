import { spawnSync } from "node:child_process"

export default {
  id: "tmux-response-status",
  tui: async (api) => {
    const pane = process.env.TMUX_PANE
    if (!process.env.TMUX || !/^%\d+$/.test(pane ?? "")) return

    const statuses = new Map()
    let displayed

    function update() {
      const route = api.route.current
      const sessionID = route.name === "session" ? route.params?.sessionID : undefined
      const status = (sessionID && statuses.get(sessionID)) || ""
      if (status === displayed) return
      displayed = status
      spawnSync("tmux", ["set-option", "-p", "-t", pane, "@opencode_status", status], { stdio: "ignore" })
      // Reapply automatic renaming only when it is already enabled.
      spawnSync("tmux", ["if-shell", "-F", "-t", pane, "#{automatic-rename}", `set-window-option -t ${pane} automatic-rename on`], { stdio: "ignore" })
    }

    const unsubscribe = api.event.on("session.status", ({ properties }) => {
      const { sessionID, status } = properties
      if (status.type === "busy" || status.type === "retry") statuses.set(sessionID, "busy")
      else if (status.type === "idle" && statuses.get(sessionID) === "busy") statuses.set(sessionID, "done")
      update()
    })

    // The active conversation can change without a status event.
    const timer = setInterval(update, 250)
    update()
    api.lifecycle.onDispose(() => {
      clearInterval(timer)
      unsubscribe()
      spawnSync("tmux", ["set-option", "-pu", "-t", pane, "@opencode_status"], { stdio: "ignore" })
    })
  },
}
