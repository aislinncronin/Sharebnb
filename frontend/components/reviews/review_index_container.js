import { connect } from 'react-redux';
import { fetchReviews, deleteReview } from '../../actions/review_actions';
import ReviewIndex from './review_index';
import { receiveCurrentModal } from '../../actions/ui_actions';
import { withRouter } from 'react-router-dom';

const msp = state => {
  return{
    reviews: state.entities.reviews,
    currentUser: state.session.currentUser
  };
};

const mdp = dispatch => {
  return{
    deleteReview: (id) => dispatch(deleteReview(id)),
    receiveCurrentModal:(currentModal) => dispatch(receiveCurrentModal(currentModal)),
    fetchReviews: (spotId) => dispatch(fetchReviews(spotId))
  };
};

export default connect(msp, mdp)(ReviewIndex);