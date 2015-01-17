# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->

  $('.signup-modal-link').on 'click',  ->
    $('#register-tab, #login-tab').removeClass('active')
    $('.auth-modal').modal('show')
    $('#register-tab').addClass('active')

  $('.login-modal-link').on 'click',  ->
    $('#register-tab, #login-tab').removeClass('active')
    $('.auth-modal').modal('show')
    $('#login-tab').addClass('active')
