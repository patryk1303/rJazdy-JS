function getDayTypes() {
	return daytypes;
}
function getStops() {
	var out = [];
	stops.forEach(function(e) {
		out.push({
			stop_id: e.id,
			name1: e.nazwa1,
			name2: e.nazwa2,
			onReq: e.nz
		});
	});
	return out;
}
function getLines() {
	var out = [];
	
	lines.forEach(function(l) {
		out.push(l);
	});
	// console.log(out);
	return out;
}
function getLineId(line) {
	return lines.filter(function(e) {
		return line==e.line;
	})[0].id;
}
function getLineFromId(line_id) {
  return lines.filter(function(e) {
    return line_id==e.id;
  })[0].line;
}
function getDirectionId(line_id,dir_no) {
	return directions.filter(function(e) {
		return line_id==e.linia_id && dir_no==e.nr_kier;
	})[0].id;
}
function getDirectionNoFromId(dir_id) {
  return directions.filter(function(e) {
    return dir_id==e.id;
  })[0].nr_kier;
}
function getDirectionNameFromId(dir_id) {
  return directions.filter(function(e) {
    return dir_id==e.id;
  })[0].kierunek;
}
function getStopName(stop_id) {
	var tmp = stops.filter(function(e) {
		return stop_id == e.id;
	})[0];
	return {
		stop_id: tmp.id,
		name1: tmp.nazwa1,
		name2: tmp.nazwa2,
		onReq: tmp.nz
	};
}
function getDirectionsForLine(line) {
	var out = [];
	var line_id = getLineId(line);
	var tmp = directions.filter(function(e) {
		return line_id==e.linia_id;
	});
	tmp.forEach(function(e) {
		out.push({
			dir_name: e.kierunek,
			dir_no: e.nr_kier
		});
	});
	return out;
}
function getStopsForDirection(line,dir_no) {
	var out = [];
	var line_id = getLineId(line);
	var dir_id  = getDirectionId(line_id,dir_no);
	var s =  routes.filter(function(e) {
		return line_id==e.linia_id && dir_id==e.kier_id;
	});
	
	//console.log(s.length);
	// console.log(s);
	s.forEach(function(e) {
		out.push(
			{
				stop_id : e.przyst_id,
				stop_name : getStopName(e.przyst_id)
			});
	});
	return out;
}
function getSigns(line,dir_no) {
	var out = [];
	var line_id = getLineId(line);
	var dir_id = getDirectionId(line_id,dir_no);
	var tmp = signs.filter(function(e) {
		return line_id==e.linia_id && dir_id==e.kier_id;
	});
	tmp.forEach(function(e) {
		out.push({sign : e.oznaczenie,description : e.opis});
	});
	return out;
}
function getSignsOnlyNeeded(line,dir_no,signs1) {
	var out = [];
	var line_id = getLineId(line);
	var dir_id = getDirectionId(line_id,dir_no);
	var tmp = signs.filter(function(e) {
		return line_id==e.linia_id && dir_id==e.kier_id
			&& (signs1.indexOf(e.oznaczenie)>=0);
	});
	tmp.forEach(function(e) {
		out.push({sign : e.oznaczenie,description : e.opis});
	});
	return out;
}
function getDepartures(line,dir_no,stop_id,daytype_id) {
	var out = [];
	var line_id = getLineId(line);
	var dir_id = getDirectionId(line_id,dir_no);
	var tmp = departures.filter(function(e) {
		return daytype_id==e.typ_dnia_id &&
					line_id==e.linia_id &&
					stop_id==e.przyst_id &&
					dir_id==e.kier_id;
	});
	tmp.forEach(function(e) {
		out.push({
			hour: e.godz,
			mins: e.min,
			signs: e.oznaczenia,
			trip_no: e.kurs_nr,
			status: e.stan
		});
	});
	return out;
}
function getHoursInDepartures(line,dir_no,stop_id) {
	var out = [];
	var line_id = getLineId(line);
	var dir_id = getDirectionId(line_id,dir_no);
	var tmp = departures.filter(function(e) {
		return	line_id==e.linia_id &&
					stop_id==e.przyst_id &&
					dir_id==e.kier_id;
	});
	tmp.forEach(function(e) {
		out.push(e.godz);
	});
	return out
		.sort(function(a,b) {return a-b})
		.filter(function(v,i,s) {return s.indexOf(v) === i});
}
function getDeparturesForHour(line,dir_no,stop_id,hour,daytype_id) {
	var out = [];
	var line_id = getLineId(line);
	var dir_id = getDirectionId(line_id,dir_no);
	var tmp = departures.filter(function(e) {
		return	daytype_id==e.typ_dnia_id &&
					line_id==e.linia_id &&
					stop_id==e.przyst_id &&
					dir_id==e.kier_id &&
					hour==e.godz;
	});
	tmp.forEach(function(e) {
		out.push({
			mins: e.min,
			signs: e.oznaczenia,
			trip_no: e.kurs_nr,
			status: e.stan
		});
	});
	return out;
}
function getDeparturesCount(line,dir_no,stop_id,daytype_id) {
	var line_id = getLineId(line);
	var dir_id = getDirectionId(line_id,dir_no);
	return departures.filter(function(e) {
		return e.linia_id == line_id && 
				e.kier_id == dir_id &&
				e.przyst_id == stop_id &&
				e.typ_dnia_id == daytype_id;
	}).length;
}
function getTrip(line,dir_no,daytype_id,trip_no) {
	var out = [];
	var line_id = getLineId(line);
	var dir_id = getDirectionId(line_id,dir_no);
	
	var tmp = departures.filter(function(e) {
		return	line_id==e.linia_id &&
					dir_id==e.kier_id &&
					daytype_id==e.typ_dnia_id &&
					trip_no==e.kurs_nr;
	});
	// console.log(tmp);
	tmp.forEach(function(e) {
		out.push({
			hour : e.godz,
			min : e.min,
			signs: e.oznaczenia,
			stop_name: getStopName(e.przyst_id)
		});
	});
	return out;
}
function getLastStopInTrip(line,dir_no,daytype_id,trip_no) {
  var line_id = getLineId(line);
  var dir_id = getDirectionId(line_id,dir_no);

  var tmp = departures.filter(function(e) {
    return  line_id==e.linia_id &&
          dir_id==e.kier_id &&
          daytype_id==e.typ_dnia_id &&
          trip_no==e.kurs_nr;
  });

  return getStopName(tmp.pop().przyst_id);
}
function getStopDepartures(stop_id,daytype_id) {
  var out = [];
  var tmp = departures.filter(function(e) {
    return  stop_id==e.przyst_id &&
            daytype_id==e.typ_dnia_id;
  });
  // console.log(tmp);
  // .when('/trip/:line/:dirNo/:stopId/:dayNo/:tripNo', {
  tmp.forEach(function(e) {
    var line = getLineFromId(e.linia_id);
    var dir_no = getDirectionNoFromId(e.kier_id);
    out.push({
       line: line,
       dir_no: dir_no,
       // stop_id: e.przyst_id,
       // stop_name: {name1:"Test", name2: "TTT", req: "1"},//getLastStopInTrip(line,dir_no,daytype_id,e.kurs_nr),
       stop_name: getLastStopInTrip(line,dir_no,daytype_id,e.kurs_nr),
       // dir_name: getDirectionNameFromId(e.kier_id),
       daytype_id: daytype_id,
       trip_no: e.kurs_nr,
       hour: e.godz,
       min: e.min
    });
  });
  return out
    .sort(function(a,b) {
      // console.log(a-b);
      return new Date('1970/01/01 ' + a.hour + ':' + a.min) - new Date('1970/01/01 ' + b.hour + ':' + b.min);
    });
}
function getOtherLinesFromStop(stop_id) {
	var out = [];

	var tmp = departures.filter(function(e) {
		return	stop_id==e.przyst_id;
	});

	tmp.forEach(function(e) {
		out.push({
			line: getLineFromId(e.linia_id),
			dir_name: getDirectionNameFromId(e.kier_id),
			dir_no: getDirectionNoFromId(e.kier_id)
		});
	});

	//console.log(out.length);

	return out.filter(function(v,i,s) {
		var j = i<s.length-1 ? i+1 : s.length-1;
		// console.log(s[j]);
		// console.log(v);
		// console.log(j);
	});
	//return out.unique();
}