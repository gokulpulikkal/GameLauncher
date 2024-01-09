function init() as void
    m.titleLabel = m.top.findNode("titleLabel")
    m.gameListing = m.top.findNode("gameListing")
    m.gameListing.setFocus(true)

    m.gameListing.observeField("itemSelected", "onItemSelected")

    centerTheListing()
end function

function centerTheListing() as void
    boundingRect = m.gameListing.boundingRect()
    xTranslation = (1920 - boundingRect.width)/2
    yTranslation = (1080 - boundingRect.height)/2
    m.gameListing.translation = [xTranslation, yTranslation]
    m.titleLabel.translation = [xTranslation - 45, yTranslation - 100]
end function

function onItemSelected(event as object) as void
    selectedIndex = event.getData()
    fieldObj = {}
    fieldObj.AddReplace("gameRequest", selectedIndex)
    m.global.update(fieldObj, true)
end function