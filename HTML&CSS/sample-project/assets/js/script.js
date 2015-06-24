
// without jquery'
var addButton = document.getElementById('appendDom');
var insertHere = document.getElementById('addStuffHere');
// with jquery'
var deleteButton = $('#removeDom');



$(document).ready(function() {

  /*
    DRAGGABLE (with jquery and jquery ui)
  */
  $(function($) {
    var dragList = $('#draggablePanelList');

    dragList.sortable({
      update: function() {
        $('.panel', dragList).each(function(index, elem) {
          var $listItem = $(elem),
            newIndex = $listItem.index();
        });
      }
    });
  });


  /*
    INFO POPOVERS (with bootstrap js, which requires/uses jquery)
  */

  //this is using bootstrap jquery
  $('#draggable-info').popover({
    content: "the tooltips and the below draggable example are using bootstrap javascript (jquery) in the JS file",
    trigger: "focus"
  });

  $('#tabs-info').popover({
    content: "the tabs are using data-attributes in the css that create the javascript actions automatically through bootstrap",
    trigger: "focus"
  });


  /*
    ADD/REMOVE CONTENT BUTTONS:
    add button: vanilla JS (meaning no libraries/jquery)
    remove button: with jquery
  */

  // function expression to add to event listener for the add content button
  var addContent = function() {
    var insertedNode = document.createElement('div');
    var stuffToAdd = "I was just added to the DOM";
    insertedNode.innerHTML = '<div id="justAdded">' + stuffToAdd + '</div>';
    insertHere.appendChild(insertedNode);
  }

  //event listener for the above vanilla javascript function
  addButton.onclick = addContent;

  //all in one function and event listener via jquery (so much easier/faster)
  $('#removeDom').click(function() {
      $('.alreadyHere:not(#willFade)').remove();
      $('#willFade').fadeOut('slow');
    }) // end add/remove content code



  // call the color animation function definitions below to start (this could have been accomplished with function expressions 
  // but i just wanted to give more different examples)
  fadeColorIn();

});


/*
  COLOR ANIMATION (with jquery and jquery ui)
*/

//this is using jQueryUI
function fadeColorIn() {
  $("#color-fade").animate({
    backgroundColor: "#ed3"
  }, 4000, function() {
    fadeColorOut();
  });
}

function fadeColorOut() {
  $("#color-fade").animate({
    backgroundColor: "#3de"
  }, 4000, function() {
    fadeColorIn();
  });
}
