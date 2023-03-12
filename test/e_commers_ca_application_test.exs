defmodule ECommersCa.ApplicationTest do
  use ExUnit.Case
  doctest ECommersCa.Application

  test "test childrens" do
    assert ECommersCa.Application.env_children(:test) == []
  end
end
