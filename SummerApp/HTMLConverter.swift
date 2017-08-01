//
//  HTMLConverter.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/27/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//
//  Private means dey cant be accessed from outside, only inside

import Foundation

// The HTMLConverter is reponsible for parsing the data from Firebase that are related to the items and creates a giant string of HTML code to load into a web view.

class HTMLConverter {
    
    //Mark: Properties
    //context is going to hold entire html string
    private static var context: String = ""
    
    //enum is collection of similar values. Can only equal to one thing at a time. 
    //AKA if u have enum for heading, it can't apply same to paragraph and what not
    private enum HTMLElement {
        case heading, paragraph, subtitle
    }
    
    private class func appendIntro() {
        context = "<!DOCTYPE HTML><html><head><link rel=\"stylesheet\" type=\"text/css\" href=\"ContentStyle.css\"></head><body><div class=\"content\">"
    }
    
    //Switch is simple if else statement. 
    //Case is just saying if tag is equal to heading then do whatever it says to do
    private class func append(_ stringValue: String, in tag: HTMLElement) {
        switch tag {
        case .heading: context += "<h1>\(stringValue)</h1>"
        case .subtitle: context += "<h2>\(stringValue)</h2>"
        case .paragraph: context += "<p>\(stringValue)</p>"
        }
    }
    
    //clears context so dat u can load a new one the next time it gets used
    private class func clear() {
        context = ""
    }
    
    
    private class func appendOutro() {
        context += "</div></body></html>"
    }
    
    //MARK: - Public Methods
    //Creates HTMK strings from the pages information for each data in Firebase and append them into a single string to load
    class func generateHTMLString(from item: [String: Any]) -> String {
        HTMLConverter.clear()
        HTMLConverter.appendIntro()
        
        var titleIndex = 1
        var paragraphIndex = 1
        var didFindValue = false
        var isPreviousStringAParagraph = false
        
        //repeat means its gonna loop once and continue to loop if the end of the while statement is true
        //Because you don't know how many times it will repeat, u use repeat
        //Repeat is sayign keep doing dis over and over again, until this while part is false.
        repeat {
            if let title = item["Title\(titleIndex)"] as? String {
                didFindValue = true
                HTMLConverter.append(title, in: .heading)
                isPreviousStringAParagraph = false
                
                //The subtitle MUST have the same number as the title it should be under
                if let subTitle = item["Subtitle\(titleIndex)"] as? String {
                    HTMLConverter.append(subTitle, in: .subtitle)
                }
            }
                
            else {
                didFindValue = false
            }
            //
            //This loop will find the paragraphs
            repeat {
                //If it found a paragraph, access that specific paragraph with ["Paragraph\(Titlendex)(paragraphIndex)"]
                //convert it into String and assign it to paragraph variable
                if let paragraph = item["P\(titleIndex)\(paragraphIndex)"] as? String {
                    didFindValue = true
                    HTMLConverter.append(paragraph, in: .paragraph)
                    
                    isPreviousStringAParagraph = true
                    paragraphIndex += 1
                }
                else {
                    isPreviousStringAParagraph = false
                }
                
            } while isPreviousStringAParagraph
            
            //Gets ready to read next title and paragraph.
            //Adds one to title bcuz it goes from title1 to Title2
            //For paragraph, it just resets and starts from one
            titleIndex += 1
            paragraphIndex = 1
            
        } while didFindValue
        
        //Adds the ending of HTML. Aka the closing tags
        HTMLConverter.appendOutro()
        
        //Finally returns the whole String which is the whole html code.
        return HTMLConverter.context
    }
}













