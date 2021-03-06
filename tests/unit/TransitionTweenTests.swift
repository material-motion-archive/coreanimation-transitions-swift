/*
 Copyright 2016-present The Material Motion Authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import XCTest
import MaterialMotionTransitions
import MaterialMotionCoreAnimationTransitions

class TransitionTweenTests: XCTestCase {

  var window: UIWindow! = nil

  override func setUp() {
    super.setUp()

    window = UIWindow()
    window.rootViewController = UIViewController()
    window.rootViewController!.view.backgroundColor = .blue
    window.makeKeyAndVisible()
    window.layer.speed = 100
  }

  class TransitionTweenDirector: NSObject, TransitionDirector {
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
      transition.runtime.addPlan(fadeIn, to: transition.foreViewController.view.layer)
    }
  }

  func testTransitionTweenTransitionDoesTerminate() {
    let toPresent = UIViewController()
    toPresent.view.backgroundColor = .red

    toPresent.mdm_transitionController.directorClass = TransitionTweenDirector.self

    let expect = expectation(description: "Did present")
    window.rootViewController!.present(toPresent, animated: true) {
      expect.fulfill()
    }
    waitForExpectations(timeout: 1)

    let expectDismiss = expectation(description: "Did dismiss")
    toPresent.dismiss(animated: true) {
      expectDismiss.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

}
