# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(() ->
	$pt = $('h3').first()
	if $pt.text().includes('Edit')
		$cs = $('input[type=submit]').last()
		$cs.css('display', 'none')
)
