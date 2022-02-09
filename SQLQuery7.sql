create proc BuscarPersonal
@desde int,
@hasta int,
@Buscador varchar(50)
as
Set Nocount on --enumera automaticamente las filas de los registros 
Select 
Id_Personal,Nombres, Identificacion, SueldoPorHora,Cargo, Id_Cargo, Estado, Codigo 
from
--se aclara que cargo viene de la tabala personal y no la tabla cargo, tambien el sueldo por hora
(Select Id_Personal,Nombres, Identificacion, Personal.SueldoPorHora, Cargo.Cargo, Personal.Id_Cargo, Estado, Codigo,  
ROW_NUMBER() Over (Order by Id_personal)'Numero_de_Fila' --enumerar 
from Personal
inner join Cargo on Cargo.Id_cargo=Personal.Id_Cargo) as Paginado
where (Paginado.Numero_de_Fila >= @desde) and (Paginado.Numero_de_Fila<=@hasta) 
and (Nombres + Identificacion like '%' + @Buscador +'%') --Sintaxis del buscador

