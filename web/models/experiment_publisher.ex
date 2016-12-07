defmodule PrivateLine.ExperimentPublisher do
  import Alchemy.Result
  require Logger

  alias Alchemy.Result

  def publish(result=%Alchemy.Result{}) do
    name       = result.experiment.name
    control    = result.control
    candidate  = hd(result.observations)
    mismatched = Result.mismatched?(result)

    Logger.debug """
    Test: #{result.experiment.name}
    Mismatch?: #{Result.mismatched?(result)}
    Control - duration: #{control.duration}
    Candidate - duration: #{candidate.duration}
    """
  end
end
