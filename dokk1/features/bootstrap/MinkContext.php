<?php

use Behat\MinkExtension\Context\MinkContext as BaseMinkContext;


/**
 * Defines application features from the specific context.
 */
class MinkContext extends BaseMinkContext
{
    /**
     * Clicks link with specified id|title|alt|text inside an element.
     * Example: When I follow "Log In" inside "header"
     * Example: And I follow "Log In" inside "header"
     *
     * @When /^(?:|I )follow "(?P<link>(?:[^"]|\\")*)" in the "(?P<containerk>(?:[^"]|\\")*)" element$/
     */
    public function clickLinkInside($link, $container)
    {
        $link = $this->fixStepArgument($link);
        $container = $this->fixStepArgument($container);
        $container = $this->getSession()->getPage()->find('css', $container);
        $link = $container->findLink($link);

        if (null === $link) {
            throw new ElementNotFoundException($this->getDriver(), 'link', 'id|title|alt|text', $locator);
        }

        $link->click();
    }
}
