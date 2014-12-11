class @RestaurantCtrl extends @ScopeCtrl
  @register()
  @inject '$rootScope', 'RestaurantSrv', '$stateParams', '$state'

  initialize: ->
    @s.r = null
    @s.tabs = [
      {heading: 'Details', route: 'restaurant.details', active:false }
      {heading: 'History', route: 'restaurant.history', active:false }
    ]

    @$rootScope.settings.layout.pageBodySolid = false
    @$rootScope.settings.layout.pageSidebarClosed = true
    @loadRestaurant()
    self = @
    @s.$on '$stateChangeSuccess', ->
      self.s.tabs.forEach (tab)->
        tab.active = self.s.active(tab.route)

  loadRestaurant: ->
    self = @
    @RestaurantSrv.getRestaurant @$stateParams.permalink, (data, status)->
      self.s.r = data
      # self.drawMap()

  publishedClass: ->
    if @s.r && @s.r.state == 'published' then 'success' else 'danger'

  isPublished: ->
    if @s.r && @s.r.state == 'published' then true else false

  websiteLink: ->
    if @s.r && @s.r.website then "http://#{@s.r.website}" else ''

  active: (route)->
    @$state.is(route)

  go: (route)->
    @$state.go(route)

  drawMap: ->
    myLatlng = new google.maps.LatLng(@s.r.address.lat, @s.r.address.lng)
    mapOptions =
      zoom: 15,
      center: myLatlng
    map = new google.maps.Map(document.getElementById('map'), mapOptions)
    marker = new google.maps.Marker
      position: myLatlng
      map: map
