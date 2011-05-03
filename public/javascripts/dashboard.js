/**
 * @author dead
 */
$(function() {
	$('#select_all').click(function() {
		if ($(this).is(':checked')) {
			$('input[name="ids[]"]').each(function() {
				$(this).attr('checked', 'checked');
			});
		} else {
			$('input[name="ids[]"]').each(function() {
				$(this).removeAttr('checked');
			});
		}
	});
});
