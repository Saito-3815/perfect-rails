require 'test_helper'

class AsyncLogJobTest < ActiveJob::TestCase
  test 'Enqueue AsyncLogJob' do
    assert_enqueued_with(job: AsyncLogJob) do
      AsyncLogJob.perform_later(message: "from test")
    end
  end
end
