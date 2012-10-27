
_fixtureSrings =
  sortableList:
    """
    <section id="sortable-list">
      <h2>Sortable List</h2>
      <ul class="sortable">
        <li>Item 1</li>
        <li>Item 2</li>
        <li>Item 3</li>
        <li>Item 4</li>
        <li>Item 5</li>
        <li>Item 6</li>
      </ul>
    </section>
    """
  sortableGrid:
    """
    <section id="sortable-grid">
      <h2>Sortable Grid</h2>
      <ul class="sortable sortable-grid">
        <li>Item 1</li>
        <li>Item 2</li>
        <li>Item 3</li>
        <li>Item 4</li>
        <li>Item 5</li>
        <li>Item 6</li>
      </ul>
    </section>
    """
  sortableWithExcludes:
    """
    <section id="sortable-with-excludes">
      <h2>Sortable With Excludes</h2>
      <ul class="sortable sortable-with-excludes">
        <li>Item 1</li>
        <li>Item 2</li>
        <li>Item 3</li>
        <li class="disabled">Item 4</li>
        <li class="disabled">Item 5</li>
        <li class="disabled">Item 6</li>
      </ul>
    </section>
    """
  sortableWithHandles:
    """
    <section id="sortable-with-handles">
      <h2>Sortable With Handles</h2>
      <ul class="sortable sortable-with-handles">
        <li><span>::</span> Item 1</li>
        <li><span>::</span> Item 2</li>
        <li><span>::</span> Item 3</li>
        <li><span>::</span> Item 4</li>
        <li><span>::</span> Item 5</li>
        <li><span>::</span> Item 6</li>
      </ul>
    </section>
    """
  sortableConnected:
    """
    <section id="sortable-connected">
      <h2>Sortable With Connected</h2>
      <ul class="sortable sortable-connected sortable-connected-1">
        <li>Item 1</li>
        <li>Item 2</li>
        <li>Item 3</li>
        <li>Item 4</li>
        <li>Item 5</li>
        <li>Item 6</li>
      </ul>
      <ul class="sortable sortable-connected sortable-connected-2">
        <li class="highlight">Item 1</li>
        <li class="highlight">Item 2</li>
        <li class="highlight">Item 3</li>
        <li class="highlight">Item 4</li>
        <li class="highlight">Item 5</li>
        <li class="highlight">Item 6</li>
      </ul>
    </section>
    """


window.TestHelper =

  fixture: (name) -> 
    _fixtureSrings[name]

  loadFixture: (name) ->
    html = @fixture(name)
    newEle = @cleanSandbox()
    newEle.html(html)
    newEle

  cleanSandbox: ->
    id = 'sandbox'
    oldEle = document.getElementById(id)
    oldEle.parentNode.removeChild(oldEle) if oldEle
    newEle = document.createElement('div')
    newEle.id = id
    document.body.appendChild(newEle)
    $(newEle)



