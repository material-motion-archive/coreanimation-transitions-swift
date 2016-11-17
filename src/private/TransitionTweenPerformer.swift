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
import MaterialMotionCoreAnimation

class TransitionTweenPerformer: NSObject, ComposablePerforming {
  let target: CALayer
  required init(target: Any) {
    self.target = target as! CALayer
    super.init()
  }

  func addPlan(_ plan: Plan) {
    let transitionTween = plan as! TransitionTween

    let from: AnyObject
    let to: AnyObject
    let segment: TransitionWindowSegment
    var timingFunction: CAMediaTimingFunction
    switch transitionTween.transition.direction {
    case .forward:
      from = transitionTween.back
      to = transitionTween.fore
      timingFunction = transitionTween.timingFunction
      segment = transitionTween.segment
    case.backward:
      from = transitionTween.fore
      to = transitionTween.back
      if let backwardTimingFunction = transitionTween.backwardTimingFunction {
        timingFunction = backwardTimingFunction
      } else {
        var first: [Float] = [0, 0]
        var second: [Float] = [0, 0]
        transitionTween.timingFunction.getControlPoint(at: 1, values: &first)
        transitionTween.timingFunction.getControlPoint(at: 2, values: &second)
        timingFunction = CAMediaTimingFunction(controlPoints: 1 - second[0], 1 - second[1],
                                               1 - first[0], 1 - first[1])
      }
      if let backwardSegment = transitionTween.backwardSegment {
        segment = TransitionWindowSegmentInverted(segment: backwardSegment)
      } else {
        segment = TransitionWindowSegmentInverted(segment: transitionTween.segment)
      }
    }

    let linear = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

    var keyTimes: [Double] = [0]
    var values: [Any] = [from]
    var timingFunctions: [CAMediaTimingFunction] = []

    if segment.position > TransitionWindowSegmentEpsilon {
      values.append(from)
      timingFunctions.append(linear)
      keyTimes.append(Double(segment.position))
    }
    timingFunctions.append(timingFunction)
    if segment.position + segment.length < 1 - TransitionWindowSegmentEpsilon {
      values.append(to)
      timingFunctions.append(linear)
      keyTimes.append(Double(segment.position + segment.length))
    }
    keyTimes.append(1)
    values.append(to)

    let tween = Tween(transitionTween.keyPath,
                      duration: transitionTween.transition.window.duration,
                      values: values)
    tween.keyPositions = keyTimes
    tween.timingFunctions = [timingFunction]
    tween.timeline = transitionTween.transition.timeline
    emitter.emitPlan(tween)

    tween.commitLastValue(to: target)
  }

  var emitter: PlanEmitting!
  func setPlanEmitter(_ planEmitter: PlanEmitting) {
    emitter = planEmitter
  }
}
