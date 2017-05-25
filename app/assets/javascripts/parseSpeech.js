function parseData(d)
    {
      var retValue;
      if(d == "oggi")
      {
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();

        if(dd<10) {
            dd='0'+dd
        } 

        if(mm<10) {
            mm='0'+mm
        } 

        retValue = dd+'.'+mm+'.'+yyyy;
      }
      else if(d == "domani")
      {
        var today = new Date();
        var dd = today.getDate() + 1;
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();

        if(dd<10) {
            dd='0'+(dd)
        } 

        if(mm<10) {
            mm='0'+mm
        } 

        retValue = dd+'.'+mm+'.'+yyyy;
      }
      else
      {
        retValue = d.replace(" ",".");
      }

      return retValue;
    }

    //nuovo task assegnatario Angelo.Giardina Categoria Scuola Data data Valore valore finito
    function parseSpeechedText(t)
    {
      var parsedSpeech = "";
      var l_ass = 12;
      var l_cat = 9;
      var l_data = 4;
      var l_val = 6;
      var retValue = t.substring(0, t.length - 6); //tolgo finito
      var retValue = (retValue.trim()).substring(11, retValue.length); //tolgo nuovo tak
      var offset;
      //assegnatario Angelo.CurtiGiardina Categoria Scuola Data data Valore finito

      if(retValue.indexOf("assegnatario") >= 0)
      {
        retValue = retValue.substring(l_ass, retValue.length); //tolgo assegnatario
        
        var indexEndAss;
        
        if(retValue.indexOf("categoria") > 0)
        {
         indexEndAss = retValue.indexOf("categoria");
         offset = l_cat;
        }
        else if(retValue.indexOf("data") > 0)
        {
          indexEndAss = retValue.indexOf("data");
          offset = l_data;
        }
        else if(retValue.indexOf("valore") > 0)
        {
           indexEndAss = retValue.indexOf("valore");
           offset = l_val;
        }

        var assignee = retValue.substring(0, indexEndAss).replace(/\s/g,'').toLowerCase();

        retValue = retValue.substring(indexEndAss, retValue.length); //riparto dal successivo

        parsedSpeech = parsedSpeech + "@" + assignee.trim();
      }

      if(retValue.indexOf("categoria") >= 0)
      {
        retValue = (retValue.trim()).substring(l_cat, retValue.length); //tolgo categoria
        var indexEndCat;
        if(retValue.indexOf("data") > 0)
        {
          indexEndCat = retValue.indexOf("data");
          offset = l_data;
        }
        else if(retValue.indexOf("valore") > 0)
        {
           indexEndCat = retValue.indexOf("valore");
           offset = l_val;
        }

        var categoria = retValue.substring(0,indexEndCat);

        retValue = retValue.substring(indexEndCat, retValue.length); //riparto da succ

        parsedSpeech = parsedSpeech + " #" + categoria.trim();

      }

      if(retValue.indexOf("data") >= 0)
      {
        retValue = (retValue.trim()).substring(l_data, retValue.length); //tolgo data
        var indexEndData;

        if(retValue.indexOf("valore") > 0)
        {
           indexEndData = retValue.indexOf("valore");
           offset = l_val;
        }

        var data = retValue.substring(0, indexEndData);

        retValue = retValue.substring(indexEndData, retValue.length);

        parsedSpeech = parsedSpeech + " !" + parseData(data.trim()) ;
      }

      if(retValue.indexOf("valore") >= 0)
      {
        retValue = (retValue.trim()).substring(l_val, retValue.length); //tolgo valore
        
        var valore = retValue.substring(0, retValue.length);

        parsedSpeech = parsedSpeech + " " + valore.trim();
      }        

      return parsedSpeech;
    }

    var finaltext;
    var settings = {
      lang: "it-IT", // GreatBritain english
      continuous:false,// Continuous mode enabled
      soundex: true,
      //listen:false, // Start recognizing
      debug:true, // Show everything in the console
      speed:1, // talk normally

      onResult:function(text){
        if(text.endsWith("finito"))
        {
          finaltext = text;  
          UserDictation.stop();
        }

        
        document.getElementById('task_value').value = text;

        if(finaltext)
        {
          document.getElementById('task_value').value = parseSpeechedText(text);
        }
  
      },

      onStart:function(){
          finaltext = null;
          console.log("Dictation started by the user");
      },
      onEnd:function(){
      }
    };

    var UserDictation;
    function startRecognition(){
      artyom.initialize({
          lang: "it-IT", // GreatBritain english
          continuous: false, // Listen forever
          soundex: true,// Use the soundex algorithm to increase accuracy
          debug: true, // Show messages in the console
          //executionKeyword: "and do it now",
          listen: false // Start to listen commands !
      }).then(() => {
          console.log("Artyom has been succesfully initialized");
      }).catch((err) => {
          console.error("Artyom couldn't be initialized: ", err);
      });
      UserDictation = artyom.newDictation(settings);
      UserDictation.start();
    }

    function stopRecognition(){
     UserDictation.stop();
   }