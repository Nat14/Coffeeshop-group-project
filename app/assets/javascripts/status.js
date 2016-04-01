// var last = false , counter = 1;
//
//
//      $(document).ready(function(){
//
//          $('.continue').hide();
//
//        var selProfessionRadio =  $('input[name=profession]:checked', '.media-option'),
//            erroEle = $(this).find('.error-message'),
//            selProfession = selProfessionRadio.closest('.mediabox');
//
//          $('.mediabox').click(function(){
//              selProfession.css({'border':'#fff 1px solid','color':"rgba(0,0,0,0.45)" ,'background':'transparent'});
//              selProfession = $(this);
//              selProfessionRadio.removeAttr('checked');
//
//              selProfessionRadio = selProfession.find('input[name=profession]')
//              selProfessionRadio.attr('checked', 'checked');
//              selProfession.css({'border':'rgba(0,0,0,0.45) 1px solid','color':"#fff" ,'background' : ' rgba(0,0,0,0.45)'});
//
//              errorMessage(erroEle ,  '', 'hidden' , 0);
//
//              $('.progress-step:nth-child('+counter+')').css('width','16%');
//              $('.continue').show(300);
//          });
//
//          $('.continue').click(function(event){
//              $('.login').css({opacity:1}).animate({marginTop : '-200px'},400);
//              $('#theform').css({opacity:0});
//              $('.progess').fadeOut(400);
//              event.preventDefault();
//          });
//
//           $('.continue').click(function(event){
//              $('.login').css({opacity:1}).animate({marginTop : '-200px'},400);
//              $('#theform').css({opacity:0});
//              $('.progess').fadeOut(400);
//              event.preventDefault();
//          });
//
//
//         $(document).keypress(function(event) {
//          if(event.which == 13) {
//              var focusInput = $(':focus');
//              $('.next').css('opacity', 0);
//              if(focusInput.val() != ''){
//                  /*--- check username and name length-------*/
//
//                  if((focusInput.attr('name') == 'name' || focusInput.attr('name') == 'username' ) && focusInput.val().length < 2)
//                  {
//                      errorMessage(erroEle ,  "isn't your "+ focusInput.attr('name') + " bit small. ", 'visible' , 1);
//                  }
//                  else if(focusInput.attr('name') == 'email' && !validateEmail(focusInput.val()))
//                  {
//                      errorMessage( erroEle ,  "It doesn't look like a "+focusInput.attr('name') , 'visible' , 1);
//                  }
//                  else if(focusInput.attr('name') == 'phone' && !validatePhone(focusInput.val()))
//                  {
//                      errorMessage( erroEle ,  "It doesn't look like a "+focusInput.attr('name') , 'visible' , 1);
//                  }
//                  else
//                  {
//                      showLi(focusInput);
//                      $('.next').css('opacity', 0);
//                      errorMessage(erroEle ,  '', 'hidden' , 0);
//                  }
//
//              }else{
//                  if(!$("input[name='profession']:checked").val())
//                  {
//                      errorMessage(erroEle ,  'please enter your '+ focusInput.attr('name'), 'visible' , 1);
//                  }
//                  else
//                  {
//                      errorMessage(erroEle ,  'please select your profession', 'visible' , 1);
//                  }
//              }
//
//              event.preventDefault();
//          }
//      });
//
//
//           $("input[type='text']").keyup(function(event) {
//              var focusInput =$(this);
//              if(!last){
//               if(focusInput.val().length > 1)
//               {
//                  if((focusInput.attr('name') == 'email' && !validateEmail(focusInput.val()))||
//                     (focusInput.attr('name') == 'phone' && !validatePhone(focusInput.val()))){
//                      $('.next').css('opacity', 0);
//                  }
//                  else{
//                       $('.next').css('opacity', 1);
//                  }
//
//               }else{
//                   $('.next').css('opacity', 0);
//               }
//              }
//          });
//
//
//
//          $("#password").keyup(function(event) {
//              var focusInput =$(this);
//              $("#viewpswd").val(focusInput.val());
//              if(focusInput.val().length > 1){
//                    $('.next').css('opacity', 1);
//              }
//          });
//
//
//          $('#show').mousedown(function() {
//              $(this).toggleClass('glyphicon-eye-open').toggleClass('glyphicon-eye-close');
//              $('#password').css('opacity',0);
//              $('#viewpswd').css('opacity',1);
//           }).mouseup(function() {
//              $(this).toggleClass('glyphicon-eye-open').toggleClass('glyphicon-eye-close');
//              $('#password').css('opacity',1);
//              $('#viewpswd').css('opacity',0);
//           });
//
//      });
//
//      function showLi(focusInput){
//
//          focusInput.closest('li').animate({
//              marginTop: '-150px',
//              opacity: 0
//          },500).addClass('done');
//
//          $('.progress-step:nth-child('+counter+')').css('width','16%');
//
//          counter++;
//          var nextli = focusInput.closest('li').next('li');
//          nextli.animate({
//              marginTop: '0px',
//              opacity: 1
//          },500);
//
//          if(nextli.is(':last-child'))
//          {
//              setTimeout(function(){
//                  $('.next').css('opacity', 0);
//              },400)
//              last = true;
//          }
//          else{
//              nextli.find('input').focus();
//          }
//      }
//
//
//      function errorMessage(textmeg , appendString , visib, opaci ){
//          textmeg.css({
//              visibility: visib
//          }).animate({
//              opacity: opaci
//          }).html(appendString)
//      }
//
//      function validateEmail(email) {
//              var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
//              return re.test(email);
//      }
//
//      function validatePhone(phone) {
//              var re = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/;
//              return re.test(phone);
//      }
