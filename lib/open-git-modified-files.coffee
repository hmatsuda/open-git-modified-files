{CompositeDisposable} = require 'atom'

module.exports = OpenGitModifiedFiles =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'open-git-modified-files:open': => @open()

  deactivate: ->
    @subscriptions.dispose()

  open: ->
    repo = atom.project.getRepo()
    for filePath of repo.statuses
      if repo.isPathModified(filePath) or repo.isPathNew(filePath)
        atom.workspace.open(filePath)
