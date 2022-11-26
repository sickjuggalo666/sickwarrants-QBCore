local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()

local jobsAuth = {
	['police'] = true,
	['bcso'] = true,
}

local BountyJobs = {
      ['bondsman'] = true,
      ['police'] = true
}

RegisterNetEvent('sickwarrants:warrantMenu')
AddEventHandler('sickwarrants:warrantMenu',function()
    local WarrantMenu = {
        {
            id = 0,
            header = 'N.C.I.C. Check',
            txt = 'Arkham Warrants'
        },
        {
            id = 1,
            header = '📲 List Warrants',
            txt = 'Get a List Of Warrants',
            params = {
                event = 'SickWarrantsMenu:optionList',
                args = {
                    selection = 'list_warrants'
                }
            }
        },
        {
            id = 2,
            header = '🔒 Create Warrant',
            txt = 'Create New Warrant',
            params = {
                event = 'SickWarrantsMenu:optionList',
                args = {
                    selection = 'create_warrants'
                }
            }
        },
    }

    local CivWarrantMenu = {
        {
            id = 0,
            header = 'N.C.I.C. Check',
            txt = 'Do You Have a Warrant?'
        },
        {
            id = 1,
            header = '📲 List Person Warrants',
            txt = 'List Person Warrants',
            params = {
                event = 'SickWarrantsMenu:optionList',
                args = {
                    selection = 'list_civ_warrants'
                }
            }
        },
    }
    if jobsAuth[PlayerData.job.name] then
	exports['qb-menu']:openMenu(WarrantMenu)
    else 
	exports['qb-menu']:openMenu(CivWarrantMenu)
    end
end)

function SetWarrantOptions(case)
   local DeleteWarrant = {
        {
            id = 0,
            header = 'Delete or Set Bounty',
            txt = 'Choose an Option Below'
        },
        {
            id = 1,
            header = 'Delete Warrant?',
            txt = 'Delete Selected Warrant?',
            params = {
                event = 'SickWarrantsMenu:optionList',
                args = {
                    selection = 'delete'
                    case = case
                }
            }
        },
    }
   local SetBounty = {
        {
            id = 0,
            header = 'Delete or Set Bounty',
            txt = 'Choose an Option Below'
        },
        {
            id = 1,
            header = 'Set a Bounty?',
            txt = 'Add a Bounty for this Warrant!',
            params = {
                event = 'SickWarrantsMenu:optionList',
                args = {
                    selection = 'set_bounty'
                    case = case
                }
            }
        },
        {
            id = 2,
            header = 'Delete Warrant?',
            txt = 'Delete Selected Warrant?',
            params = {
                event = 'SickWarrantsMenu:optionList',
                args = {
                    selection = 'delete'
                    case = case
                }
            }
        },
    }
    if BountyJobs[PlayerData.job.name] then
	exports['qb-menu']:openMenu(SetBounty)
    else 
	exports['qb-menu']:openMenu(DeleteWarrant)
    end
end

RegisterNetEvent('SickWarrantsMenu:optionList')
AddEventHandler('SickWarrantsMenu:optionList', function(args)
    if args.selection == 'delete' then  -- Deleting i THINK works but not fully tested!
        DeleteWarrant(args.case)
    elseif args.selection == 'list_civ_warrants' then
        CivWarrantList()
    elseif args.selection == 'create_warrants' then
        ShowCreateWarrantMenu()
    elseif args.selection == 'list_warrants' then
        WarrantList()
    elseif args.selection == 'warrant_choices' then
        SetWarrantOptions(args.case)
    elseif args.selection == 'set_bounty' then
        EnterBountyAmount(args.case)
    end
end)

function ShowCreateWarrantMenu()
    local dialog = exports['qb-input']:ShowInput({
        header = "Create Warrant",
        submitText = "Creating Warrants",
        inputs = {
            {
                text = "First Name",
                name = "firstName",
                type = "text",
                isRequired = true,
                -- default = "CID-1234",
            },
            {
                text = "Last Name", -- text you want to be displayed as a place holder
                name = "lastName", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                -- default = "password123", -- Default text option, this is optional
            },
            {
                text = "Case Number, -- text you want to be displayed as a place holder
                name = "caseNumber", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                -- default = 1, -- Default number option, this is optional
            },
            {
                text = "Birthday", -- text you want to be displayed as a input header
                name = "birthDay", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input - Radio is useful for "or" options e.g; billtype = Cash OR Bill OR bank
                
                -- default = "cash", -- Default radio option, must match a value from above, this is optional
            },
            {
                text = "Reason", -- text you want to be displayed as a input header
                name = "reason", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input - Check is useful for "AND" options e.g; taxincle = gst AND business AND othertax
            
            },
        },
    })

    if dialog ~= nil then
        if dialog[1].input == nil or dialog[2].input == nil or dialog[3].input == nil or dialog[4].input == nil or dialog[5].input == nil then
            Notify(3, "Dialog Bars Cannot be Empty!")
        else
            firstname = dialog[1].input,
            lastname  = dialog[2].input,
            case      = dialog[3].input,
            bday = dialog[4].input,
            reason = dialog[5].input,
            TriggerServerEvent('sickwarrants:createWarrant', firstname, lastname, case, bday, reason)
        end
    end
end

function WarrantList() --for police checking
    QBCore.Functions.TriggerServerCallback('sickwarrants:getActive', function(active)
        local counter = 2
        local WL = {
                {
                    id = 1,
                    header = 'Active Warrants',
                    txt = 'N.C.I.C',
                }
            }
            for i = 1, #active do
                table.insert(WL,{
                    id = counter,
                    header = active[i].name..', DOB: '..active[i].bday..',  Case: '..active[i].case, -- this is where the server side query reads the data. if you change server side
                    txt = "Reason: "..active[i].reason,                                              -- info make sure to change these to match!!
                    params = { 
                        event = 'SickWarrantsMenu:optionList',  
                        --isServer = true,
                        args = {
                            case = active[i].case,
                        }
                    }
                })
                counter = counter+1
            end
        exports['qb-menu']:openMenu(WL)
    end)
end

function CivWarrantList() 
    QBCore.Functions.TriggerServerCallback('sickwarrants:getActive', function(active) 
        local counter = 2                                     
        local WCL = {
                {
                    id = 1,
                    header = 'Active Warrants',
                    txt = 'N.C.I.C',
                },
            }
            for i=1, #active do
                table.insert(WCL, {
                    id = counter,
                    header = active[i].name..',  Date: '..active[i].bday..'  Case: '..active[i].case, -- this is where the server side query reads the data. if you change server side
                    txt = "Reason: "..active[i].reason.. "Bounty: "..active[i].bounty,                                               -- info make sure to change these to match!!
                })
                counter = counter+1
            end
        exports['qb-menu']:openMenu(WCL)
    end)
end

function DeleteWarrant(case)
    local DeleteWarrant = {
        {
            id = 0,
            header = 'Delete Selected Warrant?',
            txt = 'Case Number: '..case
        },
        {
            id = 1,
            header = 'YES',
            txt = 'Delete Warrant for Case Number: '..case,
            params = {
                event = 'SickWarrantsMenu:optionList',
                --isServer = true,
                args = {
                    selection = 'delete'
                    case = case
                }
            }
        },
        {
            id = 2,
            header = 'NO',
            txt = 'Cancel Deletion of Warrant?',
            params = {
                event = 'SickWarrantsMenu:optionList',
                args = {
                    selection = 'cancel'
                }
            }
        },
    }
   exports['qb-menu']:openMenu(DeleteWarrant)
end

function Notify(noty_type, message)
    if noty_type and message then
        if Config.NotificationType.client == 'esx' then
            ESX.ShowNotification(message)

        elseif Config.NotificationType.client == 'okokNotify' then
            if notif_type == 1 then
                exports['okokNotify']:Alert("Warrants", message, 10000,'success')
            elseif notif_type == 2 then
                exports['okokNotify']:Alert("Warrants", message, 10000, 'info')
            elseif notif_type == 3 then
                exports['okokNotify']:Alert("Warrants", message, 10000, 'error')
            end

        elseif Config.NotificationType.client == 'mythic' then
            if notif_type == 1 then
                exports['mythic_notify']:SendAlert('success', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            elseif notif_type == 2 then
                exports['mythic_notify']:SendAlert('inform', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            elseif notif_type == 3 then
                exports['mythic_notify']:SendAlert('error', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end

        elseif Config.NotificationType.client == 'chat' then
            TriggerEvent('chatMessage', message)
            
        elseif Config.NotificationType.client == 'other' then
            --add your own notification.
            
        end
    end
end
