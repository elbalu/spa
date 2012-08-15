// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
 //= require dust-core
//= require jquery
//= require jquery_ujs

//= require underscore
//= require backbone
//

//= require spa

//
//= require_tree ../templates/
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views
//= require_tree ./routers
//= require_tree .
$(document).ready(function(){
	alert("****");
	// $(".cb-enable").click(function(){
 //        var parent = $(this).parents('.switch');
 //        $('.cb-disable',parent).removeClass('selected');
 //        $(this).addClass('selected');
 //        $('.checkbox',parent).attr('checked', true);
 //    });
 //    $(".cb-disable").click(function(){
 //    	console.log(this);
 //        var parent = $(this).parents('.switch');
 //        $('.cb-enable',parent).removeClass('selected');
 //        $(this).addClass('selected');
 //        $('.checkbox',parent).attr('checked', false);
 //    });
$('.lendData').hide();
$('#lendRadio').click(function(){
	$('.lendData').show('slow');
	$('.requestData').hide('slow');
});
$('#requestRadio').click(function(){
	$('.lendData').hide('slow');
	$('.requestData').show('slow');
});

});
