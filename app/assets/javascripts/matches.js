// $.ajax({
//       type: 'POST',
//       url: '/segments/'+segment_id+'/track_link',
//       data: {'url': url },
//       success: function(){
//         window.open(url);
//       },
//       async:false
//     });

// $(document).ready(function() {
//   return $("#new_post").on("ajax:success", function(e, data, status, xhr) {
//     return $("#new_post").append(xhr.responseText);
//   }).bind("ajax:error", function(e, xhr, status, error) {
//     return $("#new_post").append("<p>ERROR</p>");
//   });
// });

      // success: function(e, data, status, xhr) {
      //   var comp_move = xhr.responseText;
      //   $("#"+comp_move+" div.placement").append("2");
      // };

$(function () {
  var match_id = $("div#match_id").text();
  var counter = 0;
  $('.square').on('click', function () {
    var id = this.id;
    if (counter % 2 === 0) {
      var player = "1"
     $("#"+id+" div.placement").append("1");
     counter ++
     $.ajax({
      type: 'POST',
      url: '/matches/'+match_id+'/moves/player_move',
      data: {'box': id},
      dataType: 'json',
      success: function(data) {
        $.each(data, function(index, element) {
            $('body').append($('<div>', {
                text: element.name
            }));
        });
    }
        },
      error: function(data) {
        return false;
      }
     });
     checkScore(player);
    }
    else {
      var player = "2"
      $("#"+id+" div.placement").append("2");
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