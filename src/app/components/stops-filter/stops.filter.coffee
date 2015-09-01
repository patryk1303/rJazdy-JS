angular.module 'tTableApp'
  .filter 'StopsFilter', ($log) ->
    stopsFilterFunction = (input,search) ->
      try
        input.seek (el) ->
          name = el.name1
          name += (' / ' + el.name2) if el.name2 != ''
          checkPolishStrings name,search
      catch e
        null
    stopsFilterFunction
      
# checks if txt2 is part of txt1
checkPolishStrings = (txt1,txt2) ->
  txt1 = txt1.toLowerCase()
  txt2 = txt2.toLowerCase()
  txt1 = removePolishLetters txt1
  txt2 = removePolishLetters txt2
  return if txt1.indexOf(txt2) == -1
    false
  else true

removePolishLetters = (txt) ->
  txt
    .replace(/ą/g, 'a').replace(/Ą/g, 'A')
    .replace(/ć/g, 'c').replace(/Ć/g, 'C')
    .replace(/ę/g, 'e').replace(/Ę/g, 'E')
    .replace(/ł/g, 'l').replace(/Ł/g, 'L')
    .replace(/ń/g, 'n').replace(/Ń/g, 'N')
    .replace(/ó/g, 'o').replace(/Ó/g, 'O')
    .replace(/ś/g, 's').replace(/Ś/g, 'S')
    .replace(/ż/g, 'z').replace(/Ż/g, 'Z')
    .replace(/ź/g, 'z').replace(/Ź/g, 'Z')