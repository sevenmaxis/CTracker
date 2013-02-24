$('#authentication').html("<%= escape_javascript render('users/info') %>");
$('#main').html("<%= escape_javascript render(current_user.currencies) %>");