$(function(){ 
    formStyle();
	layerCtrl();
	tapMotion();
	carousel();
	topBtn();
});

/* Form_style */
function formStyle(){
	/* Spinner */
	if($('.spinner').size() > 0){
		$( '.spinner' ).spinner({
			min: 1,
			max: 9,
			create: function( event, ui ) {
				//add custom classes and icons
				$(this)
				.next().html('<i class="icon icon-plus"></i>')
				.next().html('<i class="icon icon-minus"></i>')
			}
		});
		/*
		$('.datepicker').focus(function(){
			$(this).next().trigger('click');
		});
		*/
	}

	//inputFile	
	$('.inp_file > input').focus(function(){
		$(this).closest('.inp_file').find('.btn_file input').trigger('click');
	});	
	$('.btn_file .btn').click(function(e){
		e.preventDefault();
		$(this).closest('.inp_file').find('.btn_file input').trigger('click');
	});	
	$('.btn_file input').change(function(){
		$(this).closest('.inp_file').find('> input').val($(this).val());
	});

	/* Datepicker - Jqeury */
	if($('.datepicker').size() > 0){
		$( '.datepicker' ).datepicker({
			closeText: '닫기',
			prevText: '이전달',
			nextText: '다음달',
			currentText: '오늘',
			monthNames: ['01','02','03','04','05','06','07','08','09','10','11','12'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			dateFormat: 'yy.mm.dd',
			showMonthAfterYear: true,
			showOn: 'button',
			buttonText: '기간조회'
		});
	}
}

/* popup */
function layerCtrl(){
	$('.pop_open').click(function(){
		var _this =$(this);
		var vCont = _this.attr('href');
		
		layerShow(vCont);
		return false;
	});

	$('.pop_close').click(function(){
		var vCont = $(this).parents('.pop_bg');
		layerHide(vCont);
		return false;
	});

	$('.pop_bg').on('click',function(){
		var vCont = $(this);
		layerHide(vCont);
	}).on('click','.pop_wrap',function(e) {
		e.stopPropagation();
	});
}
function layerShow(tar){
	$('body').addClass('hidden');
	$(tar).fadeIn(300,function(){
		$(this).children().slideDown(300)
	});	
}
function layerHide(tar){
	var layer
	if(tar == undefined){
		layer = '.pop_bg';
	}else{
		layer = tar
	}	
	
	$('body').removeClass('hidden');
	$(layer).children('.pop_wrap').slideUp(300,function(){
		$(this).parent().fadeOut(300)
	})
}
function layerChange(tar){
	$('.pop_wrap').hide().closest('.pop_bg').hide();
	$(tar).show().find('.pop_wrap').show();
}

/* Tap */
function tapMotion(){	
	$('.tabMotion a').click(function() {
		var href = $(this).attr('href');		
		$(href).show().siblings('.tab_cont').hide();;
		$(this).parent().addClass('on').siblings().removeClass('on');
		return false;
    });

	if($('.tabMotion').size() > 0){
		$('.tabMotion').each(function() {
			$(this).children('li').eq(0).children('a').trigger('click');	
		}); 		
	}
}

/* FlipCountDown */
function carousel(){	
	$('.carousel').carousel()
}

/* Top_button */
function topBtn(){
	var settings ={
			button	  :'#toTop',
			text		:'컨텐츠 상단으로 이동',
			min		 :100,
			fadeIn	  :400,
			fadeOut	 :400,
			scrollSpeed :800,
			easingType  :'easeInOutExpo'
		}

	$('body').append('<a href="#" id="' + settings.button.substring(1) + '" title="' + settings.text + '">' + settings.text + '</a>');
	$(settings.button).on('click', function(e){
		$('html, body').animate({scrollTop :0}, settings.scrollSpeed, settings.easingType);
		e.preventDefault();
	})
	.on('mouseenter', function(){
		$(settings.button).addClass('hover');
	})
	.on('mouseleave', function(){
		$(settings.button).removeClass('hover');
	});

	$(window).scroll(function(){
		var position = $(window).scrollTop();
		if(position > settings.min){$(settings.button).fadeIn(settings.fadeIn);}
		else{$(settings.button).fadeOut(settings.fadeOut);}
	});
}

/* Table Row 추가 및 삭제 */
function add_row() {
	var my_tbody = document.getElementById('tbody');
	// var row = my_tbody.insertRow(0); // 상단에 추가
	var row = my_tbody.insertRow(my_tbody.rows.length ); // 하단에 추가
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	cell1.innerHTML = '<input type="text" placeholder="동전금액을 입력해주세요." title="동전금액">';
	cell2.innerHTML = '<input type="text" placeholder="개수를 입력해주세요." title="개수">';
}

function delete_row() {
	var my_tbody = document.getElementById('tbody');
	if (my_tbody.rows.length < 1) return;
	// my_tbody.deleteRow(0); // 상단부터 삭제
	my_tbody.deleteRow( my_tbody.rows.length-1 ); // 하단부터 삭제
}