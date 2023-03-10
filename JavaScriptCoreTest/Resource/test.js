function put(name){
    return "Hello "+name;
};

var colorMap = {
	"red": {"red": 255, "green": 0, "blue": 0},
	"green": {"red": 0, "green": 255, "blue": 0},
	"blue": {"red": 0, "green": 0, "blue": 255},
	"white": {"red": 255, "green": 255, "blue": 255}
};

function colorForWord(word) {
	if (!colorMap[word]) {return;}

	return makeNSColor(colorMap[word]);
};