# Standard global variables
scene = undefined
camera = undefined
renderer = undefined
controls = undefined
stats = undefined
keyboard = new THREEx.KeyboardState
clock = new THREE.Clock
gui = undefined

# Custom variables

viewerPosition = new THREE.Vector3(0.0, 0.0, 8.0)


millis = () ->
  (new Date).getTime()


toRad = (degrees) ->
  Math.PI * 2 * degree / 360


@init = () ->

  # Screen specific options
  SCREEN_WIDTH = window.innerWidth
  SCREEN_HEIGHT = window.innerHeight

  # Camera specific options
  VIEW_ANGLE = 45
  ASPECT = SCREEN_WIDTH / SCREEN_HEIGHT
  NEAR = 0.1
  FAR = 20000

  # Scene initialization
  scene = new THREE.Scene

  # Camera initialization
  camera = new THREE.PerspectiveCamera VIEW_ANGLE, ASPECT, NEAR, FAR
  camera.position.set 0, 150, 400
  camera.lookAt scene.position
  scene.add camera

  # Renderer initialization
  renderer = new THREE.WebGLRenderer antialias: true
  renderer.setSize SCREEN_WIDTH, SCREEN_HEIGHT

  # Appcontainer: an element in html document that holds our 3D application
  container = document.getElementById('appContainer')
  container.appendChild renderer.domElement

  # Window handlers
  THREEx.WindowResize renderer, camera
  THREEx.FullScreen.bindKey charCode: 'm'.charCodeAt(0)

  # Controls for moving around using mouse.
  controls = new THREE.OrbitControls camera, renderer.domElement

  # Stats: FPS counter and more
  stats = new Stats
  stats.domElement.style.position = 'absolute'
  stats.domElement.style.bottom = '0px'
  stats.domElement.style.zIndex = 100
  container.appendChild stats.domElement


  # GUI: For easy variable changing and overall control of the application
  gui = new dat.GUI
  gui_parameters = {

  }
  gui.open()


  # Light source for our world
  light = new THREE.PointLight 0xffffff
  # light = new THREE.AmbientLight 0x111111
  light.position.set 0, 250, 0
  scene.add light

  initGeometry()
  animate()


initGeometry = () ->

  # Initialize sky
  # skyBoxGeometry = new THREE.CubeGeometry 10000, 10000, 10000
  # skyBoxMaterial = new THREE.MeshBasicMaterial color: 0x9999ff, side: THREE.BackSide
  # skyBox = new THREE.Mesh skyBoxGeometry, skyBoxMaterial
  # scene.add skyBox

  scene.fog = new THREE.FogExp2 0x9999ff, 0.00025

  # Initialize floor
  floorTexture = new THREE.ImageUtils.loadTexture 'images/checkerboard.jpg'
  floorTexture.wrapS = floorTexture.wrapT = THREE.RepeatWrapping
  floorTexture.repeat.set 10, 10

  floorMaterial = new THREE.MeshBasicMaterial map: floorTexture, side: THREE.DoubleSide
  floorGeometry = new THREE.PlaneGeometry 1000, 1000, 1, 1
  floor = new THREE.Mesh floorGeometry, floorMaterial
  floor.position.x = -0.5
  floor.rotation.x = Math.PI / 2
  scene.add floor


  sphereGeometry = new THREE.SphereGeometry 50, 32, 16
  sphereMaterial = new THREE.MeshLambertMaterial color: 0x8888ff
  sphere = new THREE.Mesh sphereGeometry, sphereMaterial
  sphere.position.set 100, 50, -50
  scene.add sphere



animate = () ->
  requestAnimationFrame animate
  render()
  update()

render = () ->
  renderer.render scene, camera

update = () ->
  delta = clock.getDelta

  controls.update()
  stats.update()
