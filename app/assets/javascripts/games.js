$(function () {
  var counter = 0;
  $('.square').on('click', function () {
    var id = this.id;
    if (counter % 2 === 0) {
      var player = "X"
     $("#"+id+" div.placement").append("X");
     counter ++
     checkScore(player);
    }
    else { 
      var player = "O"
      $("#"+id+" div.placement").append("O");
      counter ++
      checkScore(player);
    }
    if (counter == 9){
      $(alert("you suck andy"));
      $('.placement').empty();
      counter = 0
    }
  });
});

function checkScore(player) {
  var row1 = $(".row1 .placement").text();
  var row2 = $(".row2 .placement").text();
  var row3 = $(".row3 .placement").text();
  var col1 = ($(".placement#oneone").text()+$(".placement#twoone").text()+$(".placement#threeone").text());
  var col2 = ($(".placement#onetwo").text()+$(".placement#twotwo").text()+$(".placement#threetwo").text());
  var col3 = ($(".placement#onethree").text()+$(".placement#twothree").text()+$(".placement#threethree").text());
  var diag1 = ($(".placement#oneone").text()+$(".placement#twotwo").text()+$(".placement#threethree").text());
  var diag2 = ($(".placement#onethree").text()+$(".placement#twotwo").text()+$(".placement#threeone").text());

  if(row1 == player+player+player){
    $(alert(player+" WINS!!"));
    location.reload();
  }
  else if(row2 == player+player+player){
    $(alert(player+" WINS!!"));
    location.reload();
  }
  else if(row3 == player+player+player){
    $(alert(player+" WINS!!"));
    location.reload();
  }
  else if(col1 == player+player+player){
    $(alert(player+" WINS!!"));
    location.reload();
  }
  else if(col2 == player+player+player){
    $(alert(player+" WINS!!"));
    location.reload();
  }
  else if(col3 == player+player+player){
    $(alert(player+" WINS!!"));
    location.reload();
  }
  else if(diag1 == player+player+player){
    $(alert(player+" WINS!!"));
    location.reload();
  }
  else if(diag2 == player+player+player){
    $(alert(player+" WINS!!"));
    location.reload();
  }
};