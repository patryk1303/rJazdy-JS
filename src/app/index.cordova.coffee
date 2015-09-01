startCordova = () ->
  doMenu = () ->
    alert 'menu'
    return
  document.addEventListener('menubutton', doMenu, true)

document.addEventListener('deviceready',startCordova,false)