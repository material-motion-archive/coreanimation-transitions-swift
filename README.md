# Core Animation transitions for Material Motion (Swift)

[![Build Status](https://travis-ci.org/material-motion/coreanimation-transitions-swift.svg?branch=develop)](https://travis-ci.org/material-motion/coreanimation-transitions-swift)
[![codecov](https://codecov.io/gh/material-motion/coreanimation-transitions-swift/branch/develop/graph/badge.svg)](https://codecov.io/gh/material-motion/coreanimation-transitions-swift)

## Supported languages

- Swift 3
- Objective-C

## Features

`TransitionTween` allows you to express a bi-directional tween during a Material Motion transition.

Consider the following example of a simple "fade in" transition director:

```swift
class FadeInTransitionDirector: NSObject, TransitionDirector {
  let transition: Transition
  required init(transition: Transition) {
    self.transition = transition
  }

  func setUp() {
    let fadeIn = TransitionTween("opacity",
                                 transition: transition,
                                 segment: .init(position: 0, length: 1),
                                 back: NSNumber(value: 0),
                                 fore: NSNumber(value: 1))
    fadeIn.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    transition.runtime.addPlan(fadeIn, to: transition.foreViewController.view.layer)
  }
}
```

In this director we've defined a single TransitionTween that handles both the forward and backward
transition. Going forward, an opacity Tween from 0 to 1 is emitted. Going backward, an opacity Tween
from 1 to 0 is emitted. In both directions the Tween occurs during the transition's entire window of
time.

## Installation

### Installation with CocoaPods

> CocoaPods is a dependency manager for Objective-C and Swift libraries. CocoaPods automates the
> process of using third-party libraries in your projects. See
> [the Getting Started guide](https://guides.cocoapods.org/using/getting-started.html) for more
> information. You can install it with the following command:
>
>     gem install cocoapods

Add `MaterialMotionCoreAnimationTransitions` to your `Podfile`:

    pod 'MaterialMotionCoreAnimationTransitions'

Then run the following command:

    pod install

### Usage

Import the framework:

    @import MaterialMotionCoreAnimationTransitions;

You will now have access to all of the APIs.

## Example apps/unit tests

Check out a local copy of the repo to access the Catalog application by running the following
commands:

    git clone https://github.com/material-motion/coreanimation-transitions-swift.git
    cd coreanimation-transitions-swift
    pod install
    open MaterialMotionCoreAnimationTransitions.xcworkspace

## Guides

1. [How to animate a CALayer property with a TransitionTween plan](#how-to-animate-a-calayer-property-with-a-transitiontween-plan)

### How to animate a CALayer property with a TransitionTween plan

Code snippets:

***In Objective-C:***

```objc
MDMTween *tween = [[MDMTween alloc] initWithKeyPath:@"<#key path#>"
                                           duration:<#duration#>
                                             values:@[<#values...#>]];
[scheduler addPlan:tween to:<#Object#>];
```

***In Swift:***

```swift

let tween = TransitionTween(<#key path#>,
                            transition: transition,
                            segment: .init(position: <#position#>, length: <#length#>),
                            back: <#back value#>,
                            fore: <#fore value#>)
transition.scheduler.addPlan(tween, to: <#Layer#>)
```

## Contributing

We welcome contributions!

Check out our [upcoming milestones](https://github.com/material-motion/coreanimation-transitions-swift/milestones).

Learn more about [our team](https://material-motion.github.io/material-motion/team/),
[our community](https://material-motion.github.io/material-motion/team/community/), and
our [contributor essentials](https://material-motion.github.io/material-motion/team/essentials/).

## License

Licensed under the Apache 2.0 license. See LICENSE for details.
