#http://adripofjavascript.com/blog/drips/object-equality-in-javascript.html
window.areObjectsEqual = (obj1,obj2) ->
  return false if typeof obj1 isnt 'object'
  return false if typeof obj2 isnt 'object'

  obj1Props = Object.getOwnPropertyNames obj1
  obj2Props = Object.getOwnPropertyNames obj2

  return false if obj1Props.length isnt obj2Props.length

  for propName in obj1Props
    return false if obj1[propName] isnt obj2[propName]

  true