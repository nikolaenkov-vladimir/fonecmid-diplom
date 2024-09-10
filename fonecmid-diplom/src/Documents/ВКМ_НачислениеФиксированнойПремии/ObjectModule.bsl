#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, РежимПроведения)  
	
	СформироватьДвижения(); 
	
	РассчитатьНДФЛ(); 
	
	РассчитатьЗарплатуКВыплате();
	
КонецПроцедуры

Процедура СформироватьДвижения() 
	
	Для Каждого ТекСтрокаСписокСотрудников Из СписокСотрудников Цикл
		
		Движение                   = Движения.ВКМ_ДополнительныеНачисления.Добавить();
		Движение.ПериодРегистрации = Дата;
		Движение.ВидРасчета        = ТекСтрокаСписокСотрудников.ВидРасчета;
		Движение.Сотрудник         = ТекСтрокаСписокСотрудников.Сотрудник;
		Движение.Результат         = ТекСтрокаСписокСотрудников.СуммаНачисления;
		
		
		Движение                      = Движения.ВКМ_Удержания.Добавить();
		Движение.ВидРасчета           = ПланыВидовРасчета.ВКМ_Удержания.НДФЛ;
		Движение.ПериодДействияНачало = НачалоМесяца(Дата);
		Движение.ПериодДействияКонец  = КонецМесяца(Дата);
		Движение.БазовыйПериодНачало  = НачалоМесяца(Дата);
		Движение.БазовыйПериодКонец   = КонецМесяца(Дата);
		Движение.ПериодРегистрации    = Дата;
		Движение.Сотрудник            = ТекСтрокаСписокСотрудников.Сотрудник;
		
	КонецЦикла;
	
	Движения.ВКМ_ДополнительныеНачисления.Записать();
	Движения.ВКМ_Удержания.Записать();
	
КонецПроцедуры

Процедура РассчитатьНДФЛ() 
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ВКМ_УдержанияБазаВКМ_ДополнительныеНачисления.Сотрудник КАК Сотрудник,
	               |	ВКМ_УдержанияБазаВКМ_ДополнительныеНачисления.РезультатБаза КАК РезультатБаза,
	               |	ВКМ_УдержанияБазаВКМ_ДополнительныеНачисления.НомерСтроки КАК НомерСтроки
	               |ИЗ
	               |	РегистрРасчета.ВКМ_Удержания.БазаВКМ_ДополнительныеНачисления(
	               |			&Измерение,
	               |			&Измерение,
	               |			&Разрез,
	               |			ВидРасчета = ЗНАЧЕНИЕ(ПланВидовРасчета.ВКМ_Удержания.НДФЛ)
	               |				И Регистратор = &Регистратор) КАК ВКМ_УдержанияБазаВКМ_ДополнительныеНачисления
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	ВКМ_УдержанияБазаВКМ_ДополнительныеНачисления.Сотрудник,
	               |	ВКМ_УдержанияБазаВКМ_ДополнительныеНачисления.РезультатБаза,
	               |	ВКМ_УдержанияБазаВКМ_ДополнительныеНачисления.НомерСтроки";
	
	Измерение = Новый Массив;
	Измерение.Добавить("Сотрудник");
	Запрос.УстановитьПараметр("Измерение", Измерение);
	
	//Начало вставки: Задача: ONEC-MID-DIPLOM. Автор: Николаенков В.А. Дата: 09.09.2024
	Разрез = Новый Массив;
	Разрез.Добавить("Регистратор");
	Запрос.УстановитьПараметр("Разрез", Разрез);
	//Конец вставки
	
	Запрос.УстановитьПараметр("Регистратор", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Запись      = Движения.ВКМ_Удержания[Выборка.НомерСтроки - 1];
		Запись.НДФЛ =(Выборка.РезультатБаза * 13) / 100;
		
	КонецЦикла;	
	
	Движения.ВКМ_Удержания.Записать();
	
КонецПроцедуры


Процедура РассчитатьЗарплатуКВыплате() 
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ВКМ_ДополнительныеНачисления.Сотрудник КАК Сотрудник,
	|	СУММА(ВКМ_ДополнительныеНачисления.Результат) КАК Результат,
	|	ВКМ_Удержания.НДФЛ КАК НДФЛ
	|ИЗ
	|	РегистрРасчета.ВКМ_ДополнительныеНачисления КАК ВКМ_ДополнительныеНачисления
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрРасчета.ВКМ_Удержания КАК ВКМ_Удержания
	|		ПО ВКМ_ДополнительныеНачисления.Сотрудник = ВКМ_Удержания.Сотрудник
	|ГДЕ
	|	ВКМ_ДополнительныеНачисления.Регистратор.Ссылка = &Ссылка
	|	И ВКМ_Удержания.Регистратор = &Ссылка
	|СГРУППИРОВАТЬ ПО
	|	ВКМ_ДополнительныеНачисления.Сотрудник,
	|	ВКМ_Удержания.НДФЛ";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Движение             = Движения.ВКМ_ВзаиморасчетыССотрудниками.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период      = Дата;
		Движение.Сотрудник   = Выборка.Сотрудник;
		Движение.Сумма       = Выборка.Результат - Выборка.НДФЛ;
		
	КонецЦикла;	
	
	Движения.ВКМ_ВзаиморасчетыССотрудниками.Записать();	
	
КонецПроцедуры

#КонецОбласти