//
//  Story.swift
//  AdventureStory
//
//  Created by Shashwath Dinesh on 4/7/24.
//

import Foundation

struct Story {
    let storyText: String //text of the story
    let choice1: String //text for the first choice
    let choice1Destination: Int //where does this choice go
    let choice2: String //text for the first choice
    let choice2Destination: Int //where does this choice go
    let storyImage: String
    let endOfStory: Bool
}


let stories = [
    //Page 0
    Story(storyText: "You are a normal citizen of the city Springhampton. One day, you enter your basement to find some old holiday decorations. After looking for a few minutes, you push a large stack of boxes to the side and are greeted with a magnificent portal. Do you:",
          choice1: "Enter the portal.",
          choice1Destination: 1,
          choice2: "Hide the portal behind the boxes and look for holiday decorations.",
          choice2Destination: 7,
          storyImage: "portal",
          endOfStory: false),
    //Page 1
        Story(storyText: "You enter the portal and are transported to a new world. You explore the strange and confusing place. After an hour of exploring, you come face-to-face with a humanlike frog. The frog tells you to follow him. Do you:",
              choice1: "Follow the frog.",
              choice1Destination: 2,
              choice2: "Keep exploring.",
              choice2Destination: 6,
              storyImage: "frog",
              endOfStory: false),

    //Page 2
        Story(storyText: "The frog leads you to a dark and ominous castle. He tells you that his realm is ruled by an evil and ruthless king, and you are the chosen one prophesized to save his realm. He begs for your help. Do you:",
              choice1: "Help the frog and his world.",
              choice1Destination: 3,
              choice2: "Leave him to wander the rest of the world yourself.",
              choice2Destination: 4,
              storyImage: "dark_castle",
              endOfStory: false),
    //Page 3
        Story(storyText: "You choose to help the frog. He tells you that you must speak to the wizard of the land to receive the necessary enchantments. Do you:",
              choice1: "Go get the enchantments",
              choice1Destination: 5,
              choice2: "Change your mind and wander the rest of the world yourself.",
              choice2Destination: 4,
              storyImage: "frog_enchantment",
              endOfStory: false),
    //Page 4
        Story(storyText: "You leave the frog and continue exploring the realm. As you wander deeper into the woods, you realize you are lost. Suddenly, you are captured by the king's guards! Fortunately, you are rescued by a mysterious man. He gives you two options: take the blue pill—the story ends, you wake up in your basement and believe whatever you want to believe. You take the red pill—you go back to the beginning, and get another chance to fix everything.",
              choice1: "Blue Pill",
              choice1Destination: 8,
              choice2: "Red Pill",
              choice2Destination: 9,
              storyImage: "matrix",
              endOfStory: false),
    //Page 5
    Story(storyText: "You get the enchantments from the wizard, and are all powered up. You go straight to the king and using your newfound powers, you take the evil king down! You reinstate law and order throughout the realm and create a safe home for all its inhabitants. Congratulations!",
              choice1: "",
              choice1Destination: 0,
              choice2: "",
              choice2Destination: 0,
              storyImage: "peacefulworld",
              endOfStory: true),
    //Page 6
        Story(storyText: "You keep wandering deeper into this new realm. You hear strange noises all around you. Suddenly, you're met with a werewolf! You look up at the full moon and you are cursed to be the alpha wolf and lead the pack for life! You should have followed the frog instead.",
              choice1: "",
              choice1Destination: 0,
              choice2: "",
              choice2Destination: 0,
              storyImage: "alpha_wolf",
              endOfStory: true),
    //Page 7
        Story(storyText: "You walk back up to the living room and finish your holiday decorations!",
              choice1: "",
              choice1Destination: 0,
              choice2: "",
              choice2Destination: 0,
              storyImage: "christmas_room",
              endOfStory: true),
    //Page 8
        Story(storyText: "One day, you wake up in your basement. You grab the holiday decorations you were looking for earlier and finish your holiday decorations upstairs. You have the best Christmas Party ever with your family!",
              choice1: "",
              choice1Destination: 0,
              choice2: "",
              choice2Destination: 0,
              storyImage: "christmas_room",
              endOfStory: true),
    //Page 9
    Story(storyText: "You teleport back to your basement. After looking for a few minutes, you find the large stack of boxes and push them to the side. You are greeted with the same magnificent portal. Do you:",
          choice1: "Enter the portal.",
          choice1Destination: 1,
          choice2: "Hide the portal behind the boxes and look for holiday decorations.",
          choice2Destination: 7,
          storyImage: "portal",
          endOfStory: false),
]
