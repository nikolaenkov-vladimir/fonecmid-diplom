
&НаКлиенте
Процедура Заполнить(Команда)
	ЗаполнитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНаСервере()
	
	ТекущийОбъект = РеквизитФормыВЗначение("Объект");
	ТекущийОбъект.ВКМ_ВыполнитьЗаполнение();
	ЗначениеВРеквизитФормы(ТекущийОбъект, "Объект");
	
КонецПроцедуры
