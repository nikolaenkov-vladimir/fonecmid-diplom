#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ,Режим)
	
	Движения.ВКМ_ГрафикиОтпусков.Записывать = Истина;
	
	Для Каждого Строка Из ОтпускаСотрудников Цикл
		Движение               = Движения.ВКМ_ГрафикиОтпусков.Добавить();
		Движение.Сотрудник     = Строка.Сотрудник;
		Движение.ДатаНачала    = Строка.ДатаНачала;
		Движение.ДатаОкончания = Строка.ДатаОкончания;
		Движение.Год           = Год;
		Движение.Регистратор   = Ссылка;	
	КонецЦИкла;
	
КонецПроцедуры

#КонецОбласти

