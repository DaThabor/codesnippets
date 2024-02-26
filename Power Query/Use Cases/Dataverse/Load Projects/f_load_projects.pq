///
 ///   Function to load data from the Dynamics 365 Project Table
///

/// Set parameters Environment and Table

///Environment (adjust the name of the Dataverse connection)
"[yourcompany].crm4.dynamics.com" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]

/// Table
"msdyn_project" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]

/// Function
let
    Source = (Environment as text, Table as text) => let
        Source = CommonDataService.Database(Environment, [CreateNavigationProperties=false]),
        msdyn_table = Source{[Schema="dbo",Item=Table]}[Data],
        #"Removed Other Columns" = Table.SelectColumns(msdyn_table,{"msdyn_projectid", "createdon", "createdby", "modifiedon", "modifiedby", "createdbyname", "modifiedbyname", "ownerid", "owneridname", "owningbusinessunit", "statecode", "statecodename", "statuscode", "statuscodename", "msdyn_subject", "msdyn_duration", "msdyn_effort", "msdyn_effortcompleted", "msdyn_effortremaining", "msdyn_finish", "msdyn_projectmanager", "msdyn_description", "msdyn_actualsales", "msdyn_actualsales_base", "msdyn_actualstart", "msdyn_customer", "msdyn_exchangerate", "msdyn_overallprojectstatus", "msdyn_overallprojectstatusname", "msdyn_totalactualcost", "msdyn_totalactualcost_base", "msdyn_totalactualsales", "msdyn_totalactualsales_base"}),
        #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"createdon", "Created On"}, {"createdby", "Created By"}})
    in
        #"Renamed Columns"
in
    Source
