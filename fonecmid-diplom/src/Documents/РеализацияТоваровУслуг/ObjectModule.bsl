
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
	#Область ОбработчикиСобытий
	
	Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
		
		Ответственный = Пользователи.ТекущийПользователь();
		
		Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ЗаказПокупателя") Тогда
			ЗаполнитьНаОснованииЗаказаПокупателя(ДанныеЗаполнения);
		КонецЕсли;
		
	КонецПроцедуры
	
	Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
		
		Если ОбменДанными.Загрузка Тогда
			Возврат;
		КонецЕсли;
		
		СуммаДокумента = Товары.Итог("Сумма") + Услуги.Итог("Сумма");
		
	КонецПроцедуры
	
	#КонецОбласти
	
	#Область СлужебныеПроцедурыИФункции
	
	Процедура ЗаполнитьНаОснованииЗаказаПокупателя(ДанныеЗаполнения)
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		|	ЗаказПокупателя.Организация КАК Организация,
		|	ЗаказПокупателя.Контрагент КАК Контрагент,
		|	ЗаказПокупателя.Договор КАК Договор,
		|	ЗаказПокупателя.СуммаДокумента КАК СуммаДокумента,
		|	ЗаказПокупателя.Товары.(
		|		Ссылка КАК Ссылка,
		|		НомерСтроки КАК НомерСтроки,
		|		Номенклатура КАК Номенклатура,
		|		Количество КАК Количество,
		|		Цена КАК Цена,
		|		Сумма КАК Сумма
		|	) КАК Товары,
		|	ЗаказПокупателя.Услуги.(
		|		Ссылка КАК Ссылка,
		|		НомерСтроки КАК НомерСтроки,
		|		Номенклатура КАК Номенклатура,
		|		Количество КАК Количество,
		|		Цена КАК Цена,
		|		Сумма КАК Сумма
		|	) КАК Услуги
		|ИЗ
		|	Документ.ЗаказПокупателя КАК ЗаказПокупателя
		|ГДЕ
		|	ЗаказПокупателя.Ссылка = &Ссылка";
		
		Запрос.УстановитьПараметр("Ссылка", ДанныеЗаполнения);
		
		Выборка = Запрос.Выполнить().Выбрать();
		
		Если Не Выборка.Следующий() Тогда
			Возврат;
		КонецЕсли;
		
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, Выборка);
		
		ТоварыОснования = Выборка.Товары.Выбрать();
		Пока ТоварыОснования.Следующий() Цикл
			ЗаполнитьЗначенияСвойств(Товары.Добавить(), ТоварыОснования);
		КонецЦикла;
		
		УслугиОснования = Выборка.Услуги.Выбрать();
		Пока ТоварыОснования.Следующий() Цикл
			ЗаполнитьЗначенияСвойств(Услуги.Добавить(), УслугиОснования);
		КонецЦикла;
		
		Основание = ДанныеЗаполнения;
		
	КонецПроцедуры
	
	
	
	
	
	//Начало вставки: Задача: ONEC-MID-DIPLOM. Автор: Николаенков В.А. Дата: 04.08.2024
	Процедура ВКМ_ВыполнитьАвтозаполнение(Договор, ДатаРеализации) Экспорт
		
		КонстантаРаботы = Константы.ВКМ_НоменклатураРаботыСпециалиста.Получить();
		КонстантаАбонентскаяПлата = Константы.ВКМ_НоменклатураАбонентскаяПлата.Получить();
		
		Если ЗначениеЗаполнено(КонстантаРаботы) и 
			ЗначениеЗаполнено(КонстантаАбонентскаяПлата) Тогда
			
			Услуги.Очистить();
			
			Если Договор.ВКМ_СуммаАбонентскойПлаты > 0 Тогда
				
				СтрокаУслугиОбслуживание = Услуги.Добавить();
				СтрокаУслугиОбслуживание.Номенклатура = КонстантаАбонентскаяПлата; 
				СтрокаУслугиОбслуживание.Количество = 1;
				СтрокаУслугиОбслуживание.Цена = Договор.ВКМ_СуммаАбонентскойПлаты;
				СтрокаУслугиОбслуживание.Сумма = Договор.ВКМ_СуммаАбонентскойПлаты;
				
				Запрос = Новый Запрос;
				Запрос.Текст = "ВЫБРАТЬ
				|	-СУММА(ВКМ_ВыполненныеКлиентуРаботыОбороты.КоличествоЧасовОборот) КАК КоличествоЧасов,
				|	-СУММА(ВКМ_ВыполненныеКлиентуРаботыОбороты.СуммаКОплатеОборот) КАК СуммаКОплате,
				|	ВКМ_ВыполненныеКлиентуРаботыОбороты.Договор КАК Договор
				|ИЗ
				|	РегистрНакопления.ВКМ_ВыполненныеКлиентуРаботы.Обороты(&ДатаНачала, &ДатаОкончания, , Договор = &Договор) КАК ВКМ_ВыполненныеКлиентуРаботыОбороты
				|
				|СГРУППИРОВАТЬ ПО
				|	ВКМ_ВыполненныеКлиентуРаботыОбороты.Договор";
				
				
				Запрос.УстановитьПараметр("Договор", Договор);
				ДатаНачала = НачалоМесяца(ДатаРеализации);
				Запрос.УстановитьПараметр("ДатаНачала", ДатаНачала);
				ДатаОкончания = КонецМесяца(ДатаРеализации);
				Запрос.УстановитьПараметр("ДатаОкончания", ДатаОкончания);
				
				Выборка = Запрос.Выполнить().Выбрать();
				
				Если Выборка.Следующий() Тогда
					
					СтрокаУслугиРаботы = Услуги.Добавить();
					СтрокаУслугиРаботы.Номенклатура = КонстантаРаботы; 
					СтрокаУслугиРаботы.Количество = Выборка.КоличествоЧасов;
					СтрокаУслугиРаботы.Цена = Выборка.СуммаКОплате;
					СтрокаУслугиРаботы.Сумма = Выборка.СуммаКОплате;
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
		СуммаДокумента = Товары.Итог("Сумма") + Услуги.Итог("Сумма");
		
	КонецПроцедуры
	//Конец вставки
	
	
	
	
	
	Процедура ОбработкаПроведения(Отказ, Режим)
		
		Движения.ОбработкаЗаказов.Записывать = Истина;
		Движения.ОстаткиТоваров.Записывать = Истина;
		
		Движение = Движения.ОбработкаЗаказов.Добавить();
		Движение.Период = Дата;
		Движение.Контрагент = Контрагент;
		Движение.Договор = Договор;
		Движение.Заказ = Основание;
		Движение.СуммаОтгрузки = СуммаДокумента;
		
		Для Каждого ТекСтрокаТовары Из Товары Цикл
			Движение = Движения.ОстаткиТоваров.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.Контрагент = Контрагент;
			Движение.Номенклатура = ТекСтрокаТовары.Номенклатура;
			Движение.Сумма = ТекСтрокаТовары.Сумма;
			Движение.Количество = ТекСтрокаТовары.Количество;
		КонецЦикла;
		
	КонецПроцедуры
	
	#КонецОбласти
	
#КонецЕсли
