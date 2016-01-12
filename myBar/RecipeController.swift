//
//  RecipeController.swift
//  myBar
//
//  Created by Sean Chang on 1/6/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import Foundation

class RecipeController {
    
    static let sharedInstance = RecipeController()
    
    var possibleRecipes: [Recipe] = []
    
    func populatePossibleRecipes(){
        self.possibleRecipes = filterRecipes(IngredientController.sharedController.myPantry, recipes: JSONController.queryRecipes())
    }
    
    func filterRecipes(inventory: [Ingredient], recipes: [Recipe]) -> [Recipe] {
        var canMake = true
        var filteredRecipes = [Recipe]()
        var inventoryStrings = [String]()
        for ingredient in inventory {
            let nameString = ingredient.name
            inventoryStrings.append(nameString)
        }
        
        for recipe in recipes {
            var recipeIngredients = [String]()
            
            
            for ingredient in recipe.ingredients{
                let ingredientName = ingredient["name"]! as String
                recipeIngredients.append(ingredientName)
            }
            
            canMake = true
            for recipeItem in recipeIngredients {
                if !inventoryStrings.contains(recipeItem) {
                    canMake = false
                }
            }
            if canMake == true {
                filteredRecipes.append(recipe)
                print(recipe.name)
            }
        }
        return filteredRecipes
    }
}

