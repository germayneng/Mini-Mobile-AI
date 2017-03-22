var initVoice = function() {
if (annyang) {
  Shiny.onInputChange('shibaa', '');

  var commands = {

    'rusty *rusty': function(thespeech) {
      Shiny.onInputChange('shibaa', thespeech);
      

    }

    
  };
  annyang.addCommands(commands);
  annyang.debug();
  annyang.start();
  




  }
};

$(function() {
  setTimeout(initVoice, 10);
});