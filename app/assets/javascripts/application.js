// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {

	$(".blocked").keydown(function(event) {                                     // para que se ingrese solo numeros
			// Allow only backspace and delete
			if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode==9) {
				// let it happen, don't do anything
			}
			else {
				// Ensure that it is a number and stop the keypress
				
	                        if (event.keyCode < 48 || event.keyCode > 57 ) {
					event.preventDefault();	
				}
					
			}
		});

	// Datepicker options
    $( ".datepicker" ).datepicker({
    	    numberOfMonths: 3,
      		dateFormat:"yy/mm/dd"
    });
    

});

