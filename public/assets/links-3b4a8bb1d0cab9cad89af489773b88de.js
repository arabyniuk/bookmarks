(function() {
  $(document).ready(function() {
    $('.signup-modal-link').on('click', function() {
      $('#register-tab, #login-tab').removeClass('active');
      $('.auth-modal').modal('show');
      return $('#register-tab').addClass('active');
    });
    return $('.login-modal-link').on('click', function() {
      $('#register-tab, #login-tab').removeClass('active');
      $('.auth-modal').modal('show');
      return $('#login-tab').addClass('active');
    });
  });

}).call(this);
