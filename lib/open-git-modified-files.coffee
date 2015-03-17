OpenGitModifiedFilesView = require './open-git-modified-files-view'
{CompositeDisposable} = require 'atom'

module.exports = OpenGitModifiedFiles =
  openGitModifiedFilesView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @openGitModifiedFilesView = new OpenGitModifiedFilesView(state.openGitModifiedFilesViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @openGitModifiedFilesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'open-git-modified-files:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @openGitModifiedFilesView.destroy()

  serialize: ->
    openGitModifiedFilesViewState: @openGitModifiedFilesView.serialize()

  toggle: ->
    repo = atom.project.getRepo()
    for filePath of repo.statuses
      console.log filePath
      atom.workspace.open(filePath)
    # 
    # console.log 'OpenGitModifiedFiles was toggled!'
    # 
    # if @modalPanel.isVisible()
    #   @modalPanel.hide()
    # else
    #   @modalPanel.show()
