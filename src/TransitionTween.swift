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

import MaterialMotionRuntime
import MaterialMotionTransitions

/**
 Interpolate a CALayer property from one value to another in the context of a transition.

 Expected target type: CALayer.
 */
@objc(MDMTransitionTween)
public final class TransitionTween: NSObject, Plan {
  /** The transition within which this tween occurs. */
  public var transition: Transition

  /** The key path of the property whose value will be tweened. */
  public var keyPath: String

  /** The destination value when the transition is moving backward. */
  public var back: AnyObject

  /** The destination value when the transition is moving foreward. */
  public var fore: AnyObject

  /**
   The timing function to use when the direction is moving forward.

   If no backwardTimingFunction is provided, this timing function will be reversed and used instead.

   Is linear pacing by default.
   */
  public var timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

  /** The timing function to use when the direction is moving backward. */
  public var backwardTimingFunction: CAMediaTimingFunction?

  /**
   The segment within the foreward transition's window during which this animation should take
   effect.
   */
  public var segment: TransitionWindowSegment

  /**
   The segment within the backward transition's window during which this animation should take
   effect.

   If nil, then segment will be used instead.
   */
  public var backwardSegment: TransitionWindowSegment?

  /** Initializes a TransitionTween with its required properties. */
  @objc(initWithKeyPath:transition:segment:back:fore:)
  public init(_ keyPath: String, transition: Transition, segment: TransitionWindowSegment, back: AnyObject, fore: AnyObject) {
    self.keyPath = keyPath
    self.transition = transition
    self.segment = segment
    self.back = back
    self.fore = fore
    super.init()
  }

  /** The performer that will fulfill this plan. */
  public func performerClass() -> AnyClass {
    return TransitionTweenPerformer.self
  }

  /** Returns a copy of this plan. */
  public func copy(with zone: NSZone? = nil) -> Any {
    let tween = TransitionTween(keyPath, transition: transition, segment: segment, back: back, fore: fore)
    tween.backwardSegment = backwardSegment
    tween.timingFunction = timingFunction
    tween.backwardTimingFunction = backwardTimingFunction
    return tween
  }
}
