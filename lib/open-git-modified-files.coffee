{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 
      'open-git-modified-files:open': => @open()

  deactivate: ->
    @subscriptions.dispose()

  open: ->
    repo = atom.project.getRepo()
    for filePath of repo.statuses
      if repo.isPathModified(filePath) or repo.isPathNew(filePath)
        atom.workspace.open(filePath)
