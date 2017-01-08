@Game.settings = {

  DEBUG: true

  # Appcontainer: an element in html document that holds our 3D application
  containerID : 'appContainer'

  ## Three.js options
  # Screen specific options
  SCREEN_WIDTH : window.innerWidth
  SCREEN_HEIGHT : window.innerHeight

  # Camera specific options
  VIEW_ANGLE : 45
  ASPECT : undefined
  NEAR : 0.1
  FAR : 20000


  ## Cannon.js options
  GRAVITY : {
    'x' : 0
    'y' : -9.8
    'z' : 0
  }
  TIMESTEP : 1 / 60

}