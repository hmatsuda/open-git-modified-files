{CompositeDisposable} = require 'atom'
path = require 'path'
fs = require 'fs-plus'

module.exports =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 
      'open-git-modified-files:open': => @open()

  deactivate: ->
    @subscriptions.dispose()

  open: ->
    for repo in atom.project.getRepositories() when repo?
      repo.async.getWorkingDirectory().then (workingDirectory) =>
        for filePath of repo.async.getCachedPathStatuses()
          filePath = path.join(workingDirectory, filePath)
          if repo.isPathModified(filePath) or repo.isPathNew(filePath)
            atom.workspace.open(filePath) if fs.isFileSync(filePath)
