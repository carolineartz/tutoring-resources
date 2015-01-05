Both declarations and expression declare a variable and put the function into it. The difference lies in how the browser parses and loads them into the execution context due to the creation time. Its important because function declarations are hoisted (they are moved to the top and processed regardless of where they are located) just as variables are, while only the variable declaration of a function expression is hoisted:

```javascript
// declaration
// function declarations needs to have a name
function sayHello1() {
  alert("Hello");
}

//If the function declaration has no name, itâ€™s considered a function expression 
//(it would be an anonymous function expression). 

// expression
var sayHello2 = function() {
  alert("Hello");
};
```

So, if the parser sees this:

```javascript
alert(hey());
var hey = function () {
  return "Hey!";
};
```

the variable declaration `var hey;` gets hoisted, but the assignment doesn't...so when it encounters the function call, it's actually just a variable, `hey`, with a value of `undefined` and you'll see `TypeError: undefined is not a function`. 

In light of this behavior, you might take this approach to adding the `win` property (a function that outputs the message to the console) to `athleteArray`.


```javascript


var dalal = {
  name: "Dalal",
  height: "5'3\"",
  sport: "100m run",
  quote: "Hard work pays off"
};


var kenn = {
  name: "Kenn",
  height: "5'6\"",
  sport: "Tennis",
  quote: "Good game"
};

var athleteArray = [dalal, kenn];

//loop calls the function
var i;
for (i = 0; i < athleteArray.length; i++) {
  winSport(athleteArray[i]);
}

//declare this function (convention aside, this could be anywhere)
function winSport(athlete) {
  athlete.win = function win() {
    return console.log(athlete.name + " won the " + athlete.sport + " event!");
  };
}

console.log(kenn);
console.log(dalal);

dalal.win();
```


**OUTPUT**
```
{ name: 'Kenn',
  height: '5\'6"',
  sport: 'Tennis',
  quote: 'Good game',
  win: [Function: win] }
{ name: 'Dalal',
  height: '5\'3"',
  sport: '100m run',
  quote: 'Hard work pays off',
  win: [Function: win] }
  
Dalal won the 100m run event!
```

