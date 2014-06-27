BTSplitViewController
=====================


![phone](/Gifs/phone.gif) ![pad](/Gifs/pad_ver.gif) 

Simple way to make a universal app!

This is a view for you to use as-is or modify the source. The view comes loaded with the ability to:

1. Handles universal app in the easiest way for Master-Detail application  
2. Handles rotation
3. Various Animation and push command
4. It should just work! like magic! 

**Background:**  
`UISplitView` and I have love-hate relation. UISplitview is very attractive to use since it helps guide your iPad apps. But the dev on this project bit off more than he can chew. The view has a lot of bells and whistles and they work well together IF you are using exactly as-is. On the other hand, it is so fragile that few customizations here and there would crack the view wide open. So I decided to strip all the bells and whistle and make sure that it just works!

**Implementation:**  
Interestingly, `UIViewController` and `UIView` implementation is firm. It will not crack even under this kind of hackery. I decided to strip out 2 views of 2 controllers (`UINavigationController` included) and embedded them directly into another UIViewController. Then I add a way to send message across the controllers by the use of `NSNotificationCenter`. All wrapped in a nice function to call in `BTSplitViewDefinition`.
 
**How to use:**

1. Import `BTSplitViewController.h` in wherever you want to show the view (root or otherwise)
2. Create 2 ViewControllers, say `masterController` and `detailController`
3. Create an instance of SplitViewController via `- (id)initWithMaster:(id)masterController detail:(id)detailController`. You are welcome to use `UINavigationController` wrapping `masterController` and `detailController` as it makes more sense.
4. Tide up loose end with the showing detail code as iPhone and iPad works differently

 ```objc
// This is very important part
    if (IS_IPAD) {
        // Create an action dictionary for modifying detail
        // See more in BTSplitViewDefinition
        NSDictionary *actionDict = [BTSplitViewDefinition actionDictWithActionType:actionType animated:animated viewController:_detailController];
        
        // Go ahead and modify the detail according to the dictionary above
        [BTSplitViewDefinition modifyDetailWithActionDict:actionDict];
        
    } else {
        // Push onto the stack as usual
        [self.navigationController pushViewController:_detailController animated:animated];
    }

 ```
5. `actionDict` is just a dictionary that holds commands and objects. Use the `actionDictWithActionType` function to create one. 
6. Profit! 

As magical as this is, you are still responsible for making sure you agressively make use of autolayout such that the view won't look weird given the change in real estates.

Please view example project to get the idea of how to implement. 

---
Copyright 2014 Byte

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
