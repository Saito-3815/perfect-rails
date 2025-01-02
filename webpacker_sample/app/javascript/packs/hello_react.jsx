import React from 'react'
import ReactDOM from 'react-dom/client'  // /rootを追加
import PropTypes from 'prop-types'

const Hello = props => (
  <div>Hello {props.name}!</div>
)

Hello.defaultProps = {
  name: 'David'
}

Hello.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  const container = document.body.appendChild(document.createElement('div'))
  const root = ReactDOM.createRoot(container)  // createRootを使用
  root.render(
    <Hello name="React" />
  )
})