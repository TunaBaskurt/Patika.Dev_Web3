import Float "mo:base/Float";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";

actor MathEngine {
    var accumulator: Float = 0;
    let MAX_LIMIT: Float = 1e38;
    let MIN_LIMIT: Float = -1e38;

    type Result = {
        #success: Float;
        #error: Text;
    };

    private func validateValue(value: Float): async () {
        if (Float.abs(value) > MAX_LIMIT) {
            Debug.print("Warning: Value exceeds limit, results may be inaccurate.");
        };
    };

    // Value Retrieval and Reset Operations
    public func reset(): async () {
        accumulator := 0;
    };

    public func getCurrentValue(): async Float {
        accumulator
    };

    public func negate(): async Float {
        accumulator := -accumulator;
        accumulator
    };

    // Arithmetic Operations
    public func increment(by: Float): async Float {
        let result = accumulator + by;
        await validateValue(result);
        accumulator := result;
        accumulator
    };

    public func decrement(by: Float): async Float {
        let result = accumulator - by;
        await validateValue(result);
        accumulator := result;
        accumulator
    };

    public func multiply(by: Float): async Float {
        let result = accumulator * by;
        await validateValue(result);
        accumulator := result;
        accumulator
    };

    public func divide(by: Float): async Result {
        if (by == 0) {
            #error("Division by zero error")
        } else {
            let result = accumulator / by;
            await validateValue(result);
            accumulator := result;
            #success(accumulator)
        }
    };

    // Advanced Mathematical Operations
    public func squareRoot(): async Result {
        if (accumulator < 0) {
            #error("Cannot take square root of a negative number")
        } else {
            let result = Float.sqrt(accumulator);
            await validateValue(result);
            accumulator := result;
            #success(accumulator)
        }
    };

    public func exponentiate(power: Float): async Result {
        if (accumulator == 0 and power < 0) {
            #error("Zero to a negative power is undefined")
        } else {
            let result = Float.pow(accumulator, power);
            await validateValue(result);
            accumulator := result;
            #success(accumulator)
        }
    };

    public func log(): async Result {
        if (accumulator <= 0) {
            #error("Logarithm of zero or negative numbers is undefined")
        } else {
            let result = Float.log(accumulator);
            await validateValue(result);
            accumulator := result;
            #success(accumulator)
        }
    };

    public func factorial(): async Result {
        let n = Int.abs(Float.toInt(accumulator));
        if (n > 10) {
            #error("Factorial for numbers greater than 20 is not supported")
        } else {
            var result = 1;
            for (i in Iter.range(1, n)) {
                result *= i;
            };
            accumulator := Float.fromInt(result);
            #success(Float.fromInt(result))
        }
    };

    // Additional Operations
    public func modulus(by: Int): async Result {
        if (by == 0) {
            #error("Modulus by zero is undefined")
        } else {
            let intAccumulator = Int.abs(Float.toInt(accumulator));
            let result = intAccumulator % by;
            accumulator := Float.fromInt(result);
            #success(accumulator)
        }
    };

    public func integrate(m: Float, b: Float, from: Float, to: Float): async Float {
        let result = (m * (to ** 2 - from ** 2) / 2) + (b * (to - from));
        await validateValue(result);
        accumulator := result;
        accumulator
    };

    public func absolute(): async Float {
        accumulator := Float.abs(accumulator);
        accumulator
    };
};
