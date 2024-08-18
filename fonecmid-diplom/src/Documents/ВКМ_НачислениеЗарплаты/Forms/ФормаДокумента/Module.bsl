
#Область  ОбработчикиКомандФормы

&НаКлиенте
Процедура Заполнить(Команда)
	
	Если ЗначениеЗаполнено(Объект.Подразделение) Тогда  
		
	ЗаполнитьНаСервере();
	
	Иначе
		ОбщегоНазначенияКлиент.СообщитьПользователю("Подразделение не заполнено! Автоматическое заполнение документа не возможно");
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНаСервере()
	
	Объект.ОсновныеНачисления.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ВКМ_ФизическиеЛица.Ссылка КАК Сотрудник
	               |ИЗ
	               |	Справочник.ВКМ_ФизическиеЛица КАК ВКМ_ФизическиеЛица
	               |ГДЕ
	               |	ВКМ_ФизическиеЛица.Подразделение = &Подразделение"; 

	Запрос.УстановитьПараметр("Подразделение", Объект.Подразделение);
	Запрос.УстановитьПараметр("НачалоПериода", (НачалоМесяца(КонецДня(Объект.Дата))));
	Запрос.УстановитьПараметр("КонецПериода", (КонецМесяца(КонецДня(Объект.Дата))));
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		НоваяСтрока = Объект.ОсновныеНачисления.Добавить();
		НоваяСтрока.Сотрудник = Выборка.Сотрудник;
		НоваяСтрока.ВидРасчета = ПланыВидовРасчета.ВКМ_ОсновныеНачисления.Оклад;
		НоваяСтрока.ДатаНачала = НачалоМесяца(Объект.Дата);
		НоваяСтрока.ДатаОкончания = КонецМесяца(Объект.Дата);
		
		Если Объект.Подразделение.Наименование = "Специалист" Тогда 
			
			НоваяСтрока.ГрафикРаботы = Справочники.ВКМ_ГрафикиРаботы.НайтиПоНаименованию("Шестидневка");
			
		Иначе 
			
			НоваяСтрока.ГрафикРаботы = Справочники.ВКМ_ГрафикиРаботы.НайтиПоНаименованию("Пятидневка");
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
