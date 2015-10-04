Array::seek = Array::seek || (callback) ->
  throw new TypeError() if typeof callback isnt 'function'

  arr = this
  out = []
  for el,i in arr
    if callback el,i,arr
      out.push el
  out

Array::each = Array::each || (callback) ->
  throw new TypeError() if typeof callback isnt 'function'

  arr = this
  for el,i in arr
    callback el,i,arr
  return
  
#https://coffeescript-cookbook.github.io/chapters/arrays/removing-duplicate-elements-from-arrays
Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

Number::between = (start, end) ->
  @ >= start and @ <= end