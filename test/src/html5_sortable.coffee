
describe 'HTML5 Sortable', ->

  cleanSandbox = ->
    TestHelper.cleanSandbox()

  loadFixture = (name) ->
    TestHelper.loadFixture(name)

  beforeEach ->
    @sandbox = cleanSandbox()

  describe 'fixture system', ->

    it 'starts off with a clean sandbox and can be cleaned up', ->
      expect($('#sandbox').html()).to.be.empty
      loadFixture 'sortableList'
      expect($('#sandbox').html()).to.not.be.empty
      cleanSandbox()
      expect($('#sandbox').html()).to.be.empty

    it 'loads an HTML fragment into the sandbox', ->
      @sandbox = loadFixture 'sortableList'
      sortable = @sandbox.find('.sortable')
      expect(sortable.length).to.not.be.empty



